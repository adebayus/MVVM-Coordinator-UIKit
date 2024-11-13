//
//  TestingRXViewController.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 13/11/24.
//

import UIKit

class TestingRXViewController: UIViewController {

    internal var viewModel: TodosViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TestingRXViewController")
        viewModel.fetchTodo()
        setupBind()
        // Do any additional setup after loading the view.
    }
    
    func setupBind() {
        viewModel.items.subscribe(
            onNext: { response in
                print(response, "kwokwowk")
            }
        )
        
        viewModel.error.subscribe(onNext: { error in
            print(error, "error")
        })
        
        
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
