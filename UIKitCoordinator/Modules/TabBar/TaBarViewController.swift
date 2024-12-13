//
//  UITabBarViewController.swift
//  UIKitCoordinator
//
//  Created by mymac on 16/11/24.
//

import UIKit

class TaBarViewController: UITabBarController {
    
    var viewModel: UITabBarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[ViewModel] -", viewModel)
        setupView()
        customizeTabBar()
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
    
    private func setupView() {
        
        var listVC: [UIViewController] = []
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
                let viewModel = ListChatTabViewModel()
                
                viewModel.coordinator = chatListCoordinator
                vc.viewModel = viewModel
            }
            
            let navController = UINavigationController(rootViewController: vc)
            listVC.append(navController)
        }
        
        
        self.viewControllers = listVC
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
}

class UITabBarViewModel {
    
    var coordinator: AuthCoordinator!
    
    let tabList: [CustomTabItem] = [
        .init(
            vc: ListChatTabVC(nibName: "ListChatTabVC", bundle: nil),
            title: "Chat",
            image: UIImage(named: "tab_chat")!
        )
    ]
}

struct CustomTabItem {
    let vc: UIViewController
    let title: String
    let image: UIImage
    var selectedImage: UIImage? = nil
}
