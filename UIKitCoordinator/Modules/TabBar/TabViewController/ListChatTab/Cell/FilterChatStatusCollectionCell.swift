//
//  FilterChatStatusCollectionCell.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 13/12/24.
//

import UIKit

struct FilterChatStatusCellModel {
    let type: FilterChatStatusType
    let name: String
}

class FilterChatStatusCollectionCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("[FilterChatStatusCollectionCell]")
        setupView()
        // Initialization code
    }
    
    private func setupView() {
        mainView.layer.cornerRadius = 16
        mainView.clipsToBounds = true
    }
    
    internal func configure(data: FilterChatStatusCellModel) {
        titleLabel.text = data.name
    }
}
