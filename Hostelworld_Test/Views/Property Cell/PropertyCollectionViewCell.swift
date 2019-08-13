//
//  PropertyCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class PropertyCollectionViewCell: UICollectionViewCell {
    
    var property: Property? {
        didSet {
            if let propertyThubnailImages = property?.images,
                let name = property?.name, let propertyTypeString = property?.type,
                let rating = property?.overallRating {
                
                for image in propertyThubnailImages {
                    let prefix = image.prefix
                    let suffix = image.suffix
                    let fulluri = "\(prefix)\(suffix)"
                    propertyThubnail.downloaded(from: fulluri, contentMode: .scaleAspectFill)
                    // if the first image is nil continue to find an image to set on the image view ... if no image set the defualt image
                    if propertyThubnail.image == nil {
                        continue
                    } else {
                        print("fulluri: ", fulluri)
                        break
                    }
                }
                
                propertyName.text = name
                propertyType.text = propertyTypeString
                let overAllRating = rating.overall ?? 0
                propertyRating.text = "\(overAllRating)"
            }
        }
    }
    
    let propertyThubnail: UIImageView = {
        let iv = UIImageView.getUIImageView(image: #imageLiteral(resourceName: "logo"), contentMode: .scaleAspectFill)
        iv.roundCorners(corners: .leftTopBottomLeft, radius: 8)
        return iv
    }()
    
    let propertyType = UILabel(text: "Tyep", color: .lightGray, fontStyle: .systemFont(ofSize: 14))
    let propertyName = UILabel(text: "Name", color: .lightGray, fontStyle: .boldSystemFont(ofSize: 18))
    let propertyRating: UILabel = {
        let lb = UILabel(text: "Rating", color: .lightGray, fontStyle: .systemFont(ofSize: 18))
        lb.textColor = .white
        lb.backgroundColor = #colorLiteral(red: 0.9540099502, green: 0.4496385455, blue: 0.2848954201, alpha: 1)
        lb.textAlignment = .center
        lb.layer.cornerRadius = 6
        lb.clipsToBounds = true
        return lb
    }()
    
    let propertyCost = UILabel(text: "$100", color: .lightGray, fontStyle: .boldSystemFont(ofSize: 20))
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setMaterialDesignTheme()
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setUpViews() {
        // H stand for horizontal layout
        propertyThubnail.setViewCGRect(width: 120, height: self.frame.height)
        let HThubnailStackView = UIStackView(arrangedSubviews: [propertyThubnail])
        addSubview(HThubnailStackView)
        HThubnailStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        propertyType.setViewCGRect(width: 0, height: 30)
        propertyName.numberOfLines = 0

        let VPropertyDetialsStackView = VirticalStackView(arrangedSubviews: [propertyType,propertyName])
        VPropertyDetialsStackView.distribution = .fillProportionally
        VPropertyDetialsStackView.spacing = 2
        addSubview(VPropertyDetialsStackView)
        VPropertyDetialsStackView.anchor(top: topAnchor, left: HThubnailStackView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 0)
       
        let VRatingStackView = VirticalStackView(arrangedSubviews: [propertyRating])
        addSubview(VRatingStackView)
        VRatingStackView.anchor(top: VPropertyDetialsStackView.bottomAnchor, left: HThubnailStackView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 45, height: 30)
        let VCostStackView = VirticalStackView(arrangedSubviews: [propertyCost])
        addSubview(VCostStackView)
        VCostStackView.anchor(top: VRatingStackView.bottomAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 2, paddingRight: 8, width: 0, height: 30)
    }
}
