//
//  ViewController.swift
//  GPSfirst
//
//  Created by 高梨健 on 2019/09/20.
//  Copyright © 2019 高梨健. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 緯度、経度表示用のラベル
        label = UILabel()
        label.frame.size = CGSize(width: 200, height: 120)
        label.center = view.center
        label.numberOfLines = 0
        view.addSubview(label)
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted, .denied:
            print("拒否されている")
            break
        case .notDetermined:
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager?.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
        label.text = "latitude: \(latitude!)\nlongitude: \(longitude!)"
    }
}
