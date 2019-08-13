//
//  PropertyImageCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class PropertyImageCollectionViewCell: BaseCollectionViewCell {
    var imageURL: String! {
        didSet {
//            print("imageURL: \(imageURL!)")
            image.downloaded(from: imageURL, contentMode: .scaleAspectFill)
        }
    }
    
    let image = UIImageView.getUIImageView(image: #imageLiteral(resourceName: "logo"), contentMode: .scaleAspectFit)
    
    override func setUpViews() {
        addSubview(image)
        image.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
