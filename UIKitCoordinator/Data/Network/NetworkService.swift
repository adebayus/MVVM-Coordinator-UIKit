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

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Decodable>(
        _ endpoint: ApiEndpoint,
        method: HTTPMethod = .get,
        paramaters: Parameters? = nil
    ) -> Observable<T> {
        
        return Observable.create { observer in
            let request = AF.request(
                endpoint.url,
                method: method,
                parameters: paramaters
            )
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
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
    func fetchTodos() -> Observable<[Todo]>
    func fetchDetail(id: Int) -> Observable<Todo>
}

class TodoRepository: TodoRepositoryProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func fetchTodos() -> RxSwift.Observable<[Todo]> {
        return networkService.request(.postAuth)
    }
    
    func fetchDetail(id: Int) -> RxSwift.Observable<Todo> {
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
                    self?.items.accept(items)
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
