//
//  MapCollectionViewCell.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/12/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapCollectionViewCell: UICollectionViewCell {

    var location: CLLocationCoordinate2D! {
        didSet {
            let mapView = MKMapView()
            mapView.isUserInteractionEnabled = false
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 700, longitudinalMeters: 700)
            mapView.setRegion(region, animated: false)
            addSubview(mapView)

            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
           
            mapView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
