//
//  LocationManager.swift
//  yumbum
//
//  Created by Yoko Yamaguchi on 12/3/15.
//  Copyright © 2015 Yoko Yamaguchi. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager : NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var llStr = ""
    var searches: Array<YelpData> = []
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[locations.count-1] as CLLocation
        let latitude = "\(location.coordinate.latitude)"
        let longtitude = "\(location.coordinate.longitude)"
        llStr = "\(latitude),\(longtitude)"
        NSLog(llStr)
        manager.stopUpdatingLocation()
        let yelp = YelpClient(ll: llStr)
        self.searches = result.searchResults
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("Error while updating location " + error.localizedDescription)
    }
}