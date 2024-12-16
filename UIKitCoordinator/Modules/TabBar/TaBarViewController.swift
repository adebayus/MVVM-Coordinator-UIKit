//
//  UITabBarViewController.swift
//  UIKitCoordinator
//
//  Created by mymac on 16/11/24.
//

import UIKit
import RxSwift

class TaBarViewController: UITabBarController {
    
    var viewModel: UITabBarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[ViewModel] -", viewModel)
//        setupView()
        setupView(isInit: true)
        setupBinds()
        customizeTabBar()
        setupLoadingView()
        viewModel.getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    init(viewModel: UITabBarViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(isInit: Bool = false) {
        
        var listVC: [UIViewController] = []
        
        if isInit {
            let initVC = UIViewController()
            listVC.append(initVC)
        } else {
            
            viewModel.tabList.forEach { item in
                
                let vc = item.vc
                let tabBar: UITabBarItem =
                    .init(
                        title: item.title,
                        image: item.image,
                        selectedImage: item.selectedImage
                    )
                vc.tabBarItem = tabBar
                
                if let vc = vc as? ListChatTabVC {
                    
                    let chatListCoordinator = ChatListCoordinator(navigationController: viewModel.coordinator.navigationController)
                    
                    let viewModel = ListChatTabViewModel(
                        coordinator: chatListCoordinator,
                        contactRepository: ContactRepository(),
                        authRepository: AuthRepository()
                    )
                    
                    vc.viewModel = viewModel
                }
                
                let navController = UINavigationController(rootViewController: vc)
                listVC.append(navController)
            }
            
        }
    
        self.viewControllers = listVC
    }
    
    private func setupBinds() {
        viewModel.isLoading.subscribe(
            onNext: { value in
                print(value, "[isLoading]")
                self.showLoadingView(isShow: value)
            }
        ).disposed(by: viewModel.dispose)
        
        viewModel.isShowRetyAlert.subscribe(
            onNext: { value in
                print(value, "[isShowRetry]")
                if value {
                    self.showRetryAlert()
                }
            }
        ).disposed(by: viewModel.dispose)
        
        viewModel.isRefreshView.subscribe(
            onNext: { value in
                
                if value {
                    self.setupView()
                }
            }
        ).disposed(by: viewModel.dispose)
    }
    
    private func customizeTabBar() {
        // Customize tab bar appearance
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            appearance.stackedLayoutAppearance.selected.iconColor = .backgroundPrimary
            
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.backgroundPrimary]
            appearance.stackedLayoutAppearance.normal.iconColor = .backgroundPrimary
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.backgroundPrimary]
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBar.barTintColor = UIColor.white
            tabBar.tintColor = UIColor.backgroundPrimary
            tabBar.unselectedItemTintColor = UIColor.backgroundUnselectTab
        }
    }
    
    private func showRetryAlert() {
        let alertController = UIAlertController(
            title: "Error",
            message: "Gagal Mendapatkan Data",
            preferredStyle: .alert
        )
        
        if viewModel.currentTry > viewModel.maxCountRetry {
            let logOut = UIAlertAction(title: "Logout", style: .default, handler: { _ in
                alertController.dismiss(animated: true)
                print("[Logut]")
            })
            
            alertController.addAction(logOut)
        } else {
            let retryAction = UIAlertAction(title: "Coba Lagi", style: .default) { alert in
                self.viewModel.getUserData()
                alertController.dismiss(animated: true)
            }
            
            alertController.addAction(retryAction)
        }
        
        self.present(alertController, animated: true)
    }
}

class UITabBarViewModel {
    
    let dispose = DisposeBag()
    let maxCountRetry = 3
    
    var currentTry = 0
    var coordinator: AuthCoordinator!
    var authRepo: AuthRepository!
    
    var isLoading = BehaviorSubject<Bool>(value: false)
    var isShowRetyAlert = BehaviorSubject<Bool>(value: false)
    var data = BehaviorSubject<DetailUserResponseModel?>(value: nil)
    var userData = PublishSubject<DetailUserResponseModel>()
    var isRefreshView = BehaviorSubject<Bool>(value: false)
    
    
    let tabList: [CustomTabItem] = [
        .init(
            vc: ListChatTabVC(nibName: "ListChatTabVC", bundle: nil),
            title: "Chat",
            image: UIImage(named: "tab_chat")!
        )
    ]
    
    func getUserData() {
        
        isLoading.onNext(true)
        
        authRepo.getDetail().subscribe(
            onNext: { data in
                self.currentTry = 0
                self.isLoading.onNext(false)
                self.isShowRetyAlert.onNext(false)
                if let data = data {
                    self.storeData(data: data)
                }
                
            },
            onError: { error in
                self.currentTry += 1
                print(error, "[error]")
                self.isLoading.onNext(false)
                self.isShowRetyAlert.onNext(true)
            }
        ).disposed(by: dispose)
    }
    
    private func storeData(data: DetailUserResponseModel) {
        KeychainManager.shared.setUserDetail(value: data)
        isRefreshView.onNext(true)
    }
    
}

struct CustomTabItem {
    let vc: UIViewController
    let title: String
    let image: UIImage
    var selectedImage: UIImage? = nil
}
