//
//  MapViewController.swift
//  Hostelworld_Test
//
//  Created by Mohsen Qaysi on 8/12/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var location: CLLocationCoordinate2D!
    
    var property: Hostel? {
        didSet {
            if let lat = property?.latitude,
                let long = property?.longitude {
                let mapView = MKMapView()
                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: Double(lat)!)!, longitude: CLLocationDegrees(exactly: Double(long)!)!)
                self.location = location
                mapView.isUserInteractionEnabled = true
                let region = MKCoordinateRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
                mapView.setRegion(region, animated: false)
//                view.addSubview(mapView)

                                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                mapView.addAnnotation(annotation)
                setupDirectionsView(mapView: mapView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationContoller()
    }
    
    private func setupNavigationContoller() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Go There", style: .plain, target: self, action: #selector(HandelNavigationButtonAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(HandelCloseButtonAction))
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
        self.title = "Map"
    }
    
    func setupDirectionsView(mapView: MKMapView) {
        var VStack: VirticalStackView!
        if let directionText = property?.directions, property?.directions != "" {
            print("directionText: ", directionText)
            let directionsView = UIView()
            directionsView.backgroundColor = .white
            
            
            VStack = VirticalStackView(arrangedSubviews: [mapView,directionsView], spacing: 0, distribution: .fillEqually)
            view.addSubview(VStack)

            let directionLable = UITextView()
            directionLable.font = .systemFont(ofSize: 20)
            directionLable.isUserInteractionEnabled = false
            directionLable.text = directionText
            
            directionsView.addSubview(directionLable)
            directionLable.anchor(top: directionsView.topAnchor, left: directionsView.leftAnchor, bottom: directionsView.bottomAnchor, right: directionsView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 0)
            
            VStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        } else {
            // if the no directions fill the view with the map
            VStack = VirticalStackView(arrangedSubviews: [mapView], spacing: 0, distribution: .fillEqually)
            view.addSubview(VStack)
            VStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }
    
    @objc func HandelCloseButtonAction(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func HandelNavigationButtonAction(){
        print(location!)
        
        if let coordinates = location {
            let reigonSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 500, longitudinalMeters: 500)
            let opsions = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: reigonSpan.center)]
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            if let locationName = property?.name {
                mapItem.name = locationName
            }
            mapItem.openInMaps(launchOptions: opsions)
        }
    }
}
