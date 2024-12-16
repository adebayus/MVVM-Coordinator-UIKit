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
        let nibFilterCell = UINib(nibName: "FilterChatStatusCollectionCell", bundle: nil)
        filterStatusCollectionView.register(nibFilterCell, forCellWithReuseIdentifier: "FilterChatStatusCollectionCell")
    }
    
    private func setupBinds() {
        viewModel
            .datasFilter
            .bind(to: filterStatusCollectionView.rx.items(cellIdentifier: "FilterChatStatusCollectionCell", cellType: FilterChatStatusCollectionCell.self)) { index, model, cell in
                cell.configure(data: model)
                
                if self.viewModel.selectedFilter.value.type == model.type {
                    cell.mainView.backgroundColor = .white
                    cell.titleLabel.textColor = .backgroundPrimary
                } else {
                    cell.mainView.backgroundColor = .backgroundPrimary
                    cell.titleLabel.textColor = .white
                }
                print("tess", model, index)
            }.disposed(by: viewModel.bag)
        
        filterStatusCollectionView.rx.itemSelected
            .subscribe(
                onNext: { indexPath in
                    let data = self.viewModel.datasFilter.value[indexPath.row]
                    
                    if data.type == .inProgress {
                        self.viewModel.goToTesting()
                    } else {
                        self.viewModel.selectedFilter.accept(data)
                        self.filterStatusCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                        self.filterStatusCollectionView.reloadData()
                    }
                   
                }
            ).disposed(by: viewModel.bag)
    }
    
    
    
}
