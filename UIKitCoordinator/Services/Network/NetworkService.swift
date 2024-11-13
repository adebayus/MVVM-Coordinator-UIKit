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


enum ApiEndpoint {
    
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    case fetchTodos
    case fetchTodoDetail(id: Int)
    
    var path: String {
        switch self {
        case .fetchTodos: "/todo"
        case .fetchTodoDetail(id: let id): "/todos/\(id)"
        }
    }
    
    var url: String {
        return ApiEndpoint.baseURL + path
    }
}

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Decodable>(_ endpoint: ApiEndpoint, method: HTTPMethod = .get, paramaters: Parameters? = nil) -> Observable<T> {
        
        return Observable.create { observer in
            let request = AF.request(endpoint.url, method: method, parameters: paramaters)
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
        return networkService.request(.fetchTodos)
    }
    
    func fetchDetail(id: Int) -> RxSwift.Observable<Todo> {
        return networkService.request(.fetchTodoDetail(id: id))
    }
}

struct Todo: Decodable {
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
