//
//  FoodDetailsViewController.swift
//  Splurged
//
//  Created by Dayo-Kayode, Adedunni on 7/15/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit
import MapKit
import SafariServices
import CoreLocation

class EntertainmentDetailsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var entertainmentDetailsMapView: MKMapView!
    
    var selectedMapItem = MKMapItem()
    let locationManager = CLLocationManager()
    var region = MKCoordinateRegion()
    var locations: [CLLocation] = []
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedMapItem.name!)
        annotation.coordinate = selectedMapItem.placemark.coordinate
        entertainmentDetailsMapView.addAnnotation(annotation)
        locationManager.requestWhenInUseAuthorization()
        entertainmentDetailsMapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        entertainmentDetailsMapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = selectedMapItem.placemark.name
        var address = selectedMapItem.placemark.subThoroughfare! + " "
        address += selectedMapItem.placemark.thoroughfare! + "\n"
        address += selectedMapItem.placemark.locality! + ", "
        address += selectedMapItem.placemark.administrativeArea! + " "
        address += selectedMapItem.placemark.postalCode!
        addressLabel.text = address
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        region = MKCoordinateRegion(center: center, span: span)
        entertainmentDetailsMapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
            pinView?.canShowCallout = true
            pinView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    @IBAction func phoneCallButton(_ sender: Any) {
        let url: NSURL = URL(string: "selectedMapItem.phoneNumber")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    
    }
    
   // selectedMapItem.phoneNumber
    @IBAction func onDirectionsButtonTapped(_ sender: Any) {
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        MKMapItem.openMaps(with: [selectedMapItem], launchOptions: launchOptions)
    }
    
    @IBAction func onWebsiteButtonTapped(_ sender: Any) {
        if let url = selectedMapItem.url {
            present(SFSafariViewController(url: url), animated: true)
        }
    }
}

