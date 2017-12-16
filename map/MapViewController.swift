//
//  MapViewController.swift
//  map
//
//  Created by stvding on 2017/12/16.
//  Copyright © 2017年 shellCom. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var listOfLocations: [Location]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        if let list = listOfLocations{
            for location in list {
                mapView.addAnnotation(location)
            }
            mapView.showAnnotations(list, animated: true)
        }
    }
}

