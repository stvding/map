//
//  Location.swift
//  map
//
//  Created by stvding on 2017/12/16.
//  Copyright © 2017年 shellCom. All rights reserved.
//

import Foundation
import MapKit

class Location: NSObject ,MKAnnotation {
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    init(lat: Double, long: Double, name: String) {
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.name = name
    }
}
