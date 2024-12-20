//
//  ListChatTabVC.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 12/12/24.
//

import UIKit
import RxSwift
import RxCocoa

class ListChatTabVC: UIViewController {
    
    var viewModel: ListChatTabViewModel!
    
    @IBOutlet weak var filterStatusCollectionView: UICollectionView!
    @IBOutlet weak var chatTableview: UITableView!
    @IBOutlet weak var totalChatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinds()
        viewModel.fetchDataFirst()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    private func setupView() {
        self.setupLoadingView()
        
        let nibFilterCell = UINib(nibName: "FilterChatStatusCollectionCell", bundle: nil)
        filterStatusCollectionView.register(nibFilterCell, forCellWithReuseIdentifier: "FilterChatStatusCollectionCell")
        
        let nibChatTableViewCell = UINib(nibName: "ChatTableViewCell", bundle: nil)
        chatTableview.register(nibChatTableViewCell, forCellReuseIdentifier: "ChatTableViewCell")
    }
    
    private func setupBinds() {
        
        viewModel.isLoading.subscribe(onNext: { isLoading in
            self.showLoadingView(isShow: isLoading)
        }).disposed(by: viewModel.bag)
        
        filterStatusCollectionView.rx.itemSelected
            .distinctUntilChanged()
            .subscribe(
                onNext: { indexPath in
                    
                    let data = self.viewModel.datasFilter.value[indexPath.row]
                    
                    self.viewModel.selectedFilter.accept(data)
                    self.filterStatusCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
                    self.filterStatusCollectionView.reloadData()
                    
                }
            ).disposed(by: viewModel.bag)
        
        viewModel.listChat
            .subscribe(onNext: { chats in
                self.totalChatLabel.text = "Total: \(chats.count) Subject"
            }).disposed(by: viewModel.bag)
        
        viewModel.rawListChat
            .subscribe(
                onNext: { chatListRaw in
                    self.viewModel.listChat.accept(chatListRaw)
                }
            ).disposed(by: viewModel.bag)
        
        viewModel.datasFilter
            .bind(to: filterStatusCollectionView.rx.items(cellIdentifier: "FilterChatStatusCollectionCell", cellType: FilterChatStatusCollectionCell.self)) { index, model, cell in
                cell.configure(data: model)
                
                if self.viewModel.selectedFilter.value.type == model.type {
                    cell.mainView.backgroundColor = .white
                    cell.titleLabel.textColor = .backgroundPrimary
                } else {
                    cell.mainView.backgroundColor = .backgroundPrimary
                    cell.titleLabel.textColor = .white
                }
               
            }.disposed(by: viewModel.bag)
        
        viewModel.listChat
            .bind(
                to: chatTableview.rx.items(
                    cellIdentifier: "ChatTableViewCell",
                    cellType: ChatTableViewCell.self)) { index, model, cell in
                      
                        let data = self.viewModel.mapperChatTableViewCell(data: model)
                        cell.configure(data: data)
                        
                    }.disposed(by: viewModel.bag)
        
        viewModel.selectedFilter
            .subscribe(onNext: { selectedFilter in
                self.viewModel.mappingFilterChat(selectedFilter: selectedFilter)
            }).disposed(by: viewModel.bag)
        
    }

}
