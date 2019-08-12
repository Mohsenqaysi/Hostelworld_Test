//
//  MainCollectionViewController.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainCollectionViewController: BaseCollectionViewController {
    
    let activityIndicotorView: UIActivityIndicatorView  = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.startAnimating()
        activity.color = #colorLiteral(red: 1, green: 0.4712502394, blue: 0.3008903339, alpha: 1)
        activity.backgroundColor = UIColor.white
        activity.hidesWhenStopped = true
        return activity
    }()
    
    var allProperties = [Property](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    let noDataView: UIView = {
        let view = UIView()
        let noDataLable = UILabel(text: "Please check that you have an internet connection 😊", color: .black, fontStyle: .boldSystemFont(ofSize: 18))
        view.addSubview(noDataLable)
        view.anchor(top:view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 18, paddingLeft: 18, paddingBottom: 18, paddingRight: 18, width: 0, height: 0)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
//        self.view.addSubview(activityIndicotorView)
        self.navigationController?.view.addSubview(activityIndicotorView)
        activityIndicotorView.center = view.center

        // Register cell classes
        self.collectionView!.register(PropertyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            HostelWorldAPI.shared.getAllPropertiesFeed { (properties, error) in
                if let error = error {
                    print("Failed to fetch data: \(error)")
                }
                properties?.properties.forEach({ (property) in
                    //                print("properties: \(property)")
                    self.allProperties.append(property)
                    //                print("========================")
                })
            }
            self.activityIndicotorView.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationContoller()
    }
    
    private func setupNavigationContoller() {
        self.title = "Properties"
        self.collectionView.contentInset = UIEdgeInsets.init(top: 12, left: 0, bottom: 12, right: 0)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
    
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allProperties.count > 0 ? allProperties.count : 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PropertyCollectionViewCell
        cell.property = allProperties[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = PropertyDetailCollectionViewController()
        detailView.propertyID = allProperties[indexPath.item].id
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width - 8 - 8, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.init(10)
    }
    
}
