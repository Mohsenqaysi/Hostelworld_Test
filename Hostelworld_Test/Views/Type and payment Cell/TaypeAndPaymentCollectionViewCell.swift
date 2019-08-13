//
//  TaypeAndPaymentCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/12/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class TaypeAndPaymentCollectionViewCell: BaseCollectionViewCell {
    
    var property: Hostel!{
        didSet {
            typeLable.text = property?.type
            if let paymentMethods = property?.paymentMethods {
                cardPaymentCollectionView.paymentMethods = paymentMethods
            }
        }
    }
    
    let propertyType = UILabel(text: "Property Type", color: .lightGray, fontStyle: .systemFont(ofSize: 16))
    let typeLable = UILabel(text: "Property Type", color: .darkGray, fontStyle: .systemFont(ofSize: 16))
    
    lazy var lineOne = UIView().getLine(width: 0, color: UIColor(white: 0.95, alpha: 1))
    let paymentLable = UILabel(text: "Payment Methons", color: .darkGray, fontStyle: .systemFont(ofSize: 16))
    let cardPaymentCollectionView = CardPaymentCollectionViewController()
    lazy var lineTwo = UIView().getLine(width: 0, color: UIColor(white: 0.95, alpha: 1))
    
  override func setUpViews() {
        
        let VTypeStackView = UIStackView(arrangedSubviews: [propertyType, typeLable])
        VTypeStackView.distribution = .equalSpacing
        addSubview(VTypeStackView)
        VTypeStackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        let HLineStackView = UIStackView(arrangedSubviews: [lineOne])
        addSubview(HLineStackView)
        HLineStackView.anchor(top: VTypeStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(paymentLable)
        paymentLable.anchor(top: HLineStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(cardPaymentCollectionView.view)
        cardPaymentCollectionView.view.anchor(top: paymentLable.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        addSubview(lineTwo)
        lineTwo.anchor(top: cardPaymentCollectionView.view.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
