//
//  NetworkService.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 13/11/24.
//

import UIKit
import Alamofire
import RxSwift
import RxRelay

struct AppErrorModel {
    let statusCode: Int
    let message: String?
    let errorList: [ErrorResponse]?
}

enum AppError: Error {
    
    case notFound(error: AppErrorModel)
    case badRequest(error: AppErrorModel)
    case serverError(error: AppErrorModel)
    case clientSide(error: AppErrorModel)
    
    enum AuthError: Error {
        case limit
        case notAutorized
        case invalidCrendential
    }
}



class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Codable>(
        _ endpoint: ApiEndpoint,
        method: HTTPMethod = .get,
        paramaters: Parameters? = nil,
        encoding: any ParameterEncoding = URLEncoding.default
    ) -> Observable<T?> {
        debugPrint(endpoint.url, T.self, "testinggg12")
        return Observable.create { observer in
            let request = SessionManager.shared.request(
                endpoint.url,
                method: method,
                parameters: paramaters,
                encoding: encoding
            )
                .responseDecodable(of: BaseResponse<T>.self) { response in
                    
                    let statusCode = response.response?.statusCode ?? 0
                    
                    switch response.result {
                    case .success(let value):
                        
                        if (200...299).contains(statusCode) {
                            observer.onNext(value.data)
                            observer.onCompleted()
                            return
                        }
                        
                        let errorModel: AppErrorModel = .init(statusCode: statusCode, message: value.message, errorList: value.errors)
                        switch statusCode {
                        case 401:
                            let message = value.message
                            
                            if message?.contains("limit") ?? false {
                                observer.onError(AppError.AuthError.limit)
                            } else if message?.contains("credentials") ?? false {
                                observer.onError(AppError.AuthError.invalidCrendential)
                            } else {
                                observer.onError(AppError.AuthError.notAutorized)
                            }
                            
                            observer.onCompleted()
                            
                            break
                        case 400:
                            observer.onError(AppError.badRequest(error: errorModel))
                            break
                        case 404:
                            observer.onError(AppError.notFound(error: errorModel))
                            break
                        case 400...499:
                            observer.onError(AppError.clientSide(error: errorModel))
                            break
                        case 500...599:
                            observer.onError(AppError.serverError(error: errorModel))
                            break
                        default:
                            break
                        }
                        
                        break
                    case .failure(let error):
                        observer.onError(error)
                        
                        break
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}



protocol TodoRepositoryProtocol {
    func fetchTodos() -> Observable<[Todo]?>
    func fetchDetail(id: Int) -> Observable<Todo?>
}

class TodoRepository: TodoRepositoryProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func fetchTodos() -> RxSwift.Observable<[Todo]?> {
        return networkService.request(.postAuth)
    }
    
    func fetchDetail(id: Int) -> RxSwift.Observable<Todo?> {
        return networkService.request(.getAuth(id: id))
    }
}

struct Todo: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

class TodosViewModel {
    private let repository: TodoRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    init(repository: TodoRepositoryProtocol = TodoRepository()) {
        self.repository = repository
    }
    
    // Observables
    let items = BehaviorRelay<[Todo]>(value: [])
    let error = PublishSubject<String>()
    
    func fetchTodo() {
        repository.fetchTodos()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] items in
                    if let items = items {
                        self?.items.accept(items)
                    }

                },
                onError: { [weak self] error in
                    self?.error.onNext(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func updateItem() {
        let itemValue = items.value
    }
}
