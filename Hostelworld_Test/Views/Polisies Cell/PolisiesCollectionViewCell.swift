//
//  PolisiesCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/12/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class PolisiesCollectionViewCell: UICollectionViewCell {
    
    var policies: [String]! {
        didSet {
            var textLayout = ""
            policies.forEach { (policy) in
                print("policy: ",policy)
              textLayout += "• \(policy)\n"
                print("textLayout: ",textLayout)
            }
            policyList.text = textLayout
        }
    }
    
    let policyLable = UILabel(text: "POLICIES", color: .darkGray, fontStyle: .systemFont(ofSize: 18))
    let policyIcon = UIImageView.getUIImageView(image: #imageLiteral(resourceName: "policies"), contentMode: .scaleAspectFit)
    let policyList = UILabel(text: "", color: .darkGray, fontStyle: .systemFont(ofSize: 18))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        policyIcon.setViewCGRect(width: 24, height: 24)
        let VPolicesStackView = UIStackView(arrangedSubviews: [policyIcon,policyLable])
        VPolicesStackView.spacing = 8
        VPolicesStackView.distribution = .fill
        addSubview(VPolicesStackView)
        VPolicesStackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        policyList.numberOfLines = 0
        addSubview(policyList)
        policyList.anchor(top: VPolicesStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
    }
}
