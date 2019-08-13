//
//  PropertyDetailCollectionViewController.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit
import CoreLocation

private let cellID = "cellID"
private let addressAndRating = "addressAndRating"
private let ratingCellID = "ratingCellID"
private let mapCellID = "mapCellID"
private let descriptionCellID = "descriptionCellID"
private let typeaAndPaymentCellID = "typeaAndPaymentCellID"
private let polisiesCellID = "polisiesCellID"


private let headerCellID = "headerCellID"

class PropertyDetailCollectionViewController: BaseCollectionViewController {
    let activityIndicotorView: UIActivityIndicatorView  = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.startAnimating()
        activity.color = #colorLiteral(red: 1, green: 0.4712502394, blue: 0.3008903339, alpha: 1)
        activity.backgroundColor = UIColor.white
        activity.hidesWhenStopped = true
        return activity
    }()
    
    var numberOfCells = 0
    var textAreaSize: CGFloat = 250.0 {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var propertyID: String? {
        didSet {
            print(propertyID!)
            guard let propertyID = propertyID else {return}
            fetchPropertyData(ID: propertyID)
        }
    }
    
    var property: Hostel?{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var propertyImages = [Image](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func fetchPropertyData(ID: String){
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            HostelWorldAPI.shared.getPropertyData(withID: ID) { (property, error) in
                if let error = error {
                    print("Fialed to fetch property data with ID: \(ID) error: \(error)")
                }
                self.property = property
                if let images = property?.images {
                    self.propertyImages = images
                }
            }
            self.numberOfCells = 6
            self.activityIndicotorView.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.view.addSubview(activityIndicotorView)
        activityIndicotorView.center = view.center
        
        // Register cells classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView!.register(AddressAndRatingCollectionViewCell.self, forCellWithReuseIdentifier: addressAndRating)
        self.collectionView!.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: ratingCellID)
        self.collectionView!.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: mapCellID)
        self.collectionView!.register(DescriptionCollectionViewCell.self, forCellWithReuseIdentifier: descriptionCellID)
        self.collectionView!.register(TaypeAndPaymentCollectionViewCell.self, forCellWithReuseIdentifier: typeaAndPaymentCellID)
        
        self.collectionView!.register(PolisiesCollectionViewCell.self, forCellWithReuseIdentifier: polisiesCellID)
        
        // Register head class
        self.collectionView!.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellID)
    }
    
    private func setupNavigationContoller() {
        self.title = ""
        self.navigationController?.navigationBar.topItem?.title = ""
        self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 12, right: 0)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .never
        self.collectionView.backgroundColor = .white
        self.navigationController?.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationContoller()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
}

extension PropertyDetailCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellID, for: indexPath) as! HeaderCollectionReusableView
        header.headerCollectionViewController.images = propertyImages
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: view.frame.width - 8 - 8, height: 250)
    }
}

extension PropertyDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells > 0 ? numberOfCells : 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        if indexPath.item == 0 {
            let addressCell = collectionView.dequeueReusableCell(withReuseIdentifier: addressAndRating, for: indexPath) as! AddressAndRatingCollectionViewCell
            self.title = property?.name
            addressCell.property = property
            return addressCell
        } else if indexPath.item == 1  {
            if property?.rating != nil {
                let ratingCell = collectionView.dequeueReusableCell(withReuseIdentifier: ratingCellID, for: indexPath) as! RatingCollectionViewCell
                ratingCell.rating = property?.rating
                return ratingCell
            }
        } else if indexPath.item == 2 {
            let mapCell = collectionView.dequeueReusableCell(withReuseIdentifier: mapCellID, for: indexPath) as! MapCollectionViewCell
                mapCell.property = property
                return mapCell
        } else if indexPath.item == 3 {
            let descriptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellID, for: indexPath) as! DescriptionCollectionViewCell
            descriptionCell.descriptionLable = property?.description
            return descriptionCell
        }  else if indexPath.item == 4 {
            if property?.type != nil {
                let typeCell = collectionView.dequeueReusableCell(withReuseIdentifier: typeaAndPaymentCellID, for: indexPath) as! TaypeAndPaymentCollectionViewCell
                typeCell.property = property
                return typeCell
            }  else {
                numberOfCells = numberOfCells - 1
            }
        } else if indexPath.item == 5 {
            if let policies = property?.policies {
                let policiesCell = collectionView.dequeueReusableCell(withReuseIdentifier: polisiesCellID, for: indexPath) as! PolisiesCollectionViewCell
                policiesCell.policies = policies
                return policiesCell
            } else {
               numberOfCells = numberOfCells - 1
            }
        }
        cell.backgroundColor = .red
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 2 {
            let mapViewController = MapViewController()
            mapViewController.property = property
            let navController = UINavigationController(rootViewController: mapViewController)
            self.navigationController?.present(navController, animated: true, completion: nil)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize.init(width: view.frame.width, height: 150)
        } else if indexPath.item == 1 {
            if property?.rating != nil {
                return CGSize.init(width: view.frame.width, height: 250)
            } else {
                return CGSize.init(width: 0, height: 0)
            }
        } else if indexPath.item == 3 {
            // get an estimatedSize height for the cell
            if let description = property?.description {
                let textEstimatedWidthSize = CGSize(width: view.frame.width - 12 - 12 - 8 - 12, height: 1500)
                let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
                let estimatedFrameSize = NSString(string: description).boundingRect(with: textEstimatedWidthSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize.init(width: view.frame.width, height: estimatedFrameSize.height + 60)
            } else {
                return CGSize.init(width: view.frame.width, height: 0)
            }
        } else {
            return CGSize.init(width: view.frame.width, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.init(1)
    }
}
