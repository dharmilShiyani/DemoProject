//
//  LocationManager.swift
//

import UIKit
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    let locationManager = CLLocationManager()
    var provideLocationBlock: ((_ locationManager: CLLocationManager,_ location: CLLocation)->(Bool))?
    var location: CLLocation?
    
    private override init() {
        super.init()
        
    }
    
    func getLocationUpdates(completionHandler: @escaping ((_ locationManager: CLLocationManager,_ location: CLLocation)->(Bool))) {
        location = nil
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        provideLocationBlock = completionHandler
        
    }
    
    func getPlacemark(fromLocation location: CLLocation, completionBlock: @escaping ((CLPlacemark)->())) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                if let placemark = placemarks!.first {
                    completionBlock(placemark)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count == 0 {
            return
        }
        
        if let block = provideLocationBlock {
            if location == nil {
                location = locations.last!
                if block(locationManager,location!) {
                    locationManager.stopUpdatingLocation()
                } else {
                    location = nil
                }
            }
        }
    }
}
