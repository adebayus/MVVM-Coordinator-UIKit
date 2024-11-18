//
//  TestingRXViewController.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 13/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class TestingRXViewController: UIViewController {

    internal var viewModel: TodosViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TestingRXViewController")
        viewModel.fetchTodo()
        setupBind()
        testing()

        print(self.view.subviews, "list subview")
        // Do any additional setup after loading the view.
    }
    
    func setupBind() {
        viewModel.items.subscribe(
            onNext: { response in
                print(response, "kwokwowk")
            }
        ).disposed(by: disposeBag)
        
        viewModel.error.subscribe(onNext: { error in
            print(error, "error")
        }).disposed(by: disposeBag)
        
        
        
    }
    
    func testing() {
        
        let one = 1
        let two = 2
        let three = 3
        
        let observable = Observable<Int>.just(one)
        let observable2 = Observable.of(one, two, three)
        let observable3 = Observable.of([one, two, three])
        let observable4 = Observable.from([one, two, three])
        let observableVoid = Observable<Void>.empty()
        let observable6 = Observable<Int>.range(start: 1, count: 10)

        
        observable.subscribe(
            onNext: { value in
                print(value, "observable-")
            },
            onCompleted: {
                print("completed", "observable-")
            }
        ).disposed(by: disposeBag)
        
        
        observable2.subscribe(onNext: { value in
            print(value, "observable2-")
        }).disposed(by: disposeBag)
        
        observable3.subscribe(onNext: { value in
            print(value, "observable3-")
        }).disposed(by: disposeBag)
        
        observable4.subscribe(onNext: { value in
            print(value, "observable4-")
        }).disposed(by: disposeBag)
        
        observableVoid.subscribe(
            onNext: { value in
                print(value, "observable5-")
            },
            onCompleted: {
                print("completed", "observable5-")
            }
            
        ).disposed(by: disposeBag)
        
        observable6
           .subscribe(onNext: { i in
             // 2
             let n = Double(i)

             let fibonacci = Int(
               ((pow(1.61803, n) - pow(0.61803, n)) /
                 2.23606).rounded()
             )

             print(fibonacci, "observable6-")
         }).disposed(by: disposeBag)
        
        Observable<String>.create { observer in
          // 1
          observer.onNext("1")

          // 2
//          observer.onCompleted()

          // 3
          observer.onNext("?")

          // 4
          return Disposables.create()
        }.subscribe(
            onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
          )
          .disposed(by: disposeBag)
        
        
    }


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
