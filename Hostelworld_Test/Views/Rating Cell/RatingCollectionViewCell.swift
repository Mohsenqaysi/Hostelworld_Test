//
//  RatingCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/12/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class RatingCollectionViewCell: BaseCollectionViewCell {
    
    var rating: Rating? {
        didSet {
            if let loaction = rating?.location,
                let cleanlines = rating?.cleanliness,
                let staff =  rating?.staff,
                let facilities =  rating?.facilities,
                let atmosphere = rating?.atmosphere,
                let security = rating?.security,
                let valueForMoney = rating?.valueForMoney {
                
                let loaction = getSlider(label: "Location", rating: loaction)
                let cleanlines = getSlider(label: "Cleanlines", rating: cleanlines)
                let staff = getSlider(label: "Staff", rating: staff)
                let facilities = getSlider(label: "Facilities", rating: facilities)
                let atmosphere =  getSlider(label: "Atmosphere", rating: atmosphere)
                let security = getSlider(label: "Security", rating: security)
                let valueForMoney = getSlider(label: "Value For Money", rating: valueForMoney)
                
                let VSliderStackView = VirticalStackView(arrangedSubviews: [loaction,cleanlines,staff,facilities,atmosphere,security,valueForMoney], spacing: 2, distribution: .fillProportionally)
                addSubview(VSliderStackView)
                VSliderStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 18, width: 0, height: 0)
            }
        }
    }

    func getSlider(label: String, rating: Int) -> UIStackView {
        let ratingLabel = UILabel(text: label,color: .darkGray, fontStyle: .systemFont(ofSize: 14))
        let slider: UISlider = {
            let sl = UISlider()
            sl.minimumValue = 0
            sl.maximumValue = 100
            sl.setThumbImage(UIImage(), for: .normal) // hide the image
            sl.minimumTrackTintColor = #colorLiteral(red: 1, green: 0.4712502394, blue: 0.3008903339, alpha: 1)
            sl.isUserInteractionEnabled = false
            return sl
        }()
        let sliderating = UILabel(text: "\(rating)", color: #colorLiteral(red: 1, green: 0.4712502394, blue: 0.3008903339, alpha: 1), fontStyle: .boldSystemFont(ofSize: 14))
        ratingLabel.textAlignment = .left
        ratingLabel.setViewCGRect(width: 150, height: 30)
        slider.setValue(Float(rating), animated: true)
        let HSliderStackView = UIStackView(arrangedSubviews: [ratingLabel,slider,sliderating])
        HSliderStackView.spacing = 12
        HSliderStackView.distribution = .fill
        HSliderStackView.alignment = .center
        return HSliderStackView
    }
}
