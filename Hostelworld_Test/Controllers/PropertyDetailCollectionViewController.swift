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

private let headerCellID = "headerCellID"

class PropertyDetailCollectionViewController: BaseCollectionViewController {
    var numberOfCells = 4
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
        HostelWorldAPI.shared.getPropertyData(withID: ID) { (property, error) in
            if let error = error {
                print("Fialed to fetch property data with ID: \(ID) error: \(error)")
            }
            self.property = property
            if let images = property?.images {
//                print(images)
                self.propertyImages = images
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationContoller()
       
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView!.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: ratingCellID)
        
         self.collectionView!.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: mapCellID)

        self.collectionView!.register(AddressAndRatingCollectionViewCell.self, forCellWithReuseIdentifier: addressAndRating)
        self.collectionView!.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellID)
    }
    
    private func setupNavigationContoller() {
        self.title = "Property Name"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 12, right: 0)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .never
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
            } else {
                numberOfCells = numberOfCells - 1
            }
        } else if indexPath.item == 2 {
            let mapCell = collectionView.dequeueReusableCell(withReuseIdentifier: mapCellID, for: indexPath) as! MapCollectionViewCell
            if let lat = property?.latitude,
                let long = property?.longitude {
               
                let loaction = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: Double(lat)!)!, longitude: CLLocationDegrees(exactly: Double(long)!)!)
                mapCell.location = loaction
                return mapCell
            }
        }
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize.init(width: view.frame.width, height: 150)
        } else if indexPath.item == 1 {
            return CGSize.init(width: view.frame.width, height: 250)
        } else {
            return CGSize.init(width: view.frame.width, height: 200)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.init(1)
    }
}
