//
//  CardPaymentCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/12/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class CardPaymentCollectionViewCell: UICollectionViewCell {
    var imageName: String! {
        didSet {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            if let imageFound = UIImage(named: imageName){
                imageView.image = imageFound
            } else {
                imageView.image = #imageLiteral(resourceName: "logo")
            }
            addSubview(imageView)
            imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
