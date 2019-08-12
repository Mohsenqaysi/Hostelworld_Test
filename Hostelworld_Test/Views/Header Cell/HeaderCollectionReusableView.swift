//
//  HeaderCollectionReusableView.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    let headerCollectionViewController = HeaderCollectionViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       headerCollectionViewController.view.backgroundColor = .blue
        addSubview(headerCollectionViewController.view)
        // Fill the whole view with the contoller
        headerCollectionViewController.view.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
