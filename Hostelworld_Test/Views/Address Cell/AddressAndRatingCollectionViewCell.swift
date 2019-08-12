//
//  AddressAndRatingCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/10/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class AddressAndRatingCollectionViewCell: UICollectionViewCell {
    var property: Hostel? {
        didSet {
            if let address1 = property?.address1, let address2 = property?.address2, let cityName = property?.city?.name, let country = property?.city?.country {
                address.text = "\(address1) \(address2) \(cityName) \(country)"
            }
            let name = property?.name
            propertyName.text = name
            if let overAllRating = property?.rating?.overall {
                propertyRating.text = "\(overAllRating)"
            }
        }
    }
    
    let propertyName = UILabel(text: "N/A", color: .darkGray, fontStyle: .boldSystemFont(ofSize: 18))
    let addressIcon =  UIImageView.getUIImageView(image:#imageLiteral(resourceName: "marker"), contentMode: .scaleAspectFit)

    let address =  UILabel(text: "N/A", color: .darkGray, fontStyle: .systemFont(ofSize: 16))
    lazy var lineOne = UIView().getLine(width: 0, color: UIColor(white: 0.95, alpha: 1))
    
    let overAllRating = UILabel(text: "Overall Rating", color: .darkGray, fontStyle: .systemFont(ofSize: 18))
    let propertyRating: UILabel = {
        let lb = UILabel(text: "0", color: .lightGray, fontStyle: .systemFont(ofSize: 18))
        lb.textColor = .white
        lb.backgroundColor = #colorLiteral(red: 0.9540099502, green: 0.4496385455, blue: 0.2848954201, alpha: 1)
        lb.textAlignment = .center
        lb.layer.cornerRadius = 6
        lb.clipsToBounds = true
        return lb
    }()
    lazy var lineTwo = UIView().getLine(width: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = .white
        address.numberOfLines = 2
        
        addressIcon.setViewCGRect(width: 24, height: 24)
        let HAddressStackView = UIStackView(arrangedSubviews: [addressIcon,address])
        let VNameAndAddressStackView = VirticalStackView(arrangedSubviews: [propertyName,HAddressStackView], spacing: 2, distribution: .fill)
        addSubview(VNameAndAddressStackView)
        VNameAndAddressStackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
       
        let HLineStackView = UIStackView(arrangedSubviews: [lineOne])
        addSubview(HLineStackView)
        HLineStackView.anchor(top: VNameAndAddressStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       
        propertyRating.setViewCGRect(width: 70, height: 30)
        let HRataingStackView = UIStackView(arrangedSubviews: [overAllRating,propertyRating])
        addSubview(HRataingStackView)
        HRataingStackView.anchor(top: HLineStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
        
    }
}
