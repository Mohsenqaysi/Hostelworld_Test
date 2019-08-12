//
//  InfoCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/12/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    let textArea = UILabel()
    var descriptionLable: String! {
        didSet {
            textArea.numberOfLines = 0
            if let descriptionLable = descriptionLable {
                textArea.text = "INFORMATION\n\n\(descriptionLable)"
                textArea.font = UIFont.systemFont(ofSize: 16)
                textArea.textColor = .darkGray
                addSubview(textArea)
                textArea.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
                print("descriptionLable: \(String(describing: descriptionLable))")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}