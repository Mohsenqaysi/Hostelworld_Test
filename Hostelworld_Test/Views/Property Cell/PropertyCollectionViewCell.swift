//
//  PropertyCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class PropertyCollectionViewCell: BaseCollectionViewCell {
    
    let propertyThubnail: UIImageView = {
        let iv = UIImageView.getUIImageView(image: #imageLiteral(resourceName: "1"), contentMode: .scaleAspectFill)
        iv.roundCorners(corners: .leftTopBottomLeft, radius: 12)
        return iv
    }()
    
    let propertyType = UILabel(text: "HOSTEL", color: .lightGray, fontStyle: .systemFont(ofSize: 14))
    let propertyName = UILabel(text: "Backpackers Göteborg", color: .lightGray, fontStyle: .boldSystemFont(ofSize: 18))
    let propertyRating: UILabel = {
        let lb = UILabel(text: "8.7", color: .lightGray, fontStyle: .systemFont(ofSize: 18))
        lb.textColor = .white
        lb.backgroundColor = #colorLiteral(red: 0.9540099502, green: 0.4496385455, blue: 0.2848954201, alpha: 1)
        lb.textAlignment = .center
        lb.layer.cornerRadius = 8
        lb.clipsToBounds = true
        return lb
    }()
    
    let propertyCost = UILabel(text: "$25", color: .lightGray, fontStyle: .boldSystemFont(ofSize: 20))

    override func setUpViews() {
        // H stand for horizontal layout
        propertyThubnail.setViewCGRect(width: 120, height: self.frame.height)
        let HThubnailStackView = UIStackView(arrangedSubviews: [propertyThubnail])
        addSubview(HThubnailStackView)
        HThubnailStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        propertyType.setViewCGRect(width: 0, height: 30)
        let VPropertyDetialsStackView = VirticalStackView(arrangedSubviews: [propertyType,propertyName])
        VPropertyDetialsStackView.distribution = .fillProportionally
        VPropertyDetialsStackView.spacing = 1
        addSubview(VPropertyDetialsStackView)
        VPropertyDetialsStackView.anchor(top: topAnchor, left: HThubnailStackView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 0)
       
        let VRatingStackView = VirticalStackView(arrangedSubviews: [propertyRating])
        addSubview(VRatingStackView)
        VRatingStackView.anchor(top: VPropertyDetialsStackView.bottomAnchor, left: HThubnailStackView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 50, height: 30)
        let VCostStackView = VirticalStackView(arrangedSubviews: [propertyCost])
        addSubview(VCostStackView)
        VCostStackView.anchor(top: VRatingStackView.bottomAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 2, paddingRight: 8, width: 0, height: 30)

    }
}
