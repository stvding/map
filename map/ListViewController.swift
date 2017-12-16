//
//  ViewController.swift
//  map
//
//  Created by stvding on 2017/12/16.
//  Copyright © 2017年 shellCom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var locationsTable: UITableView!
    var listOfLocations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationsTable.delegate = self
        self.locationsTable.dataSource = self
        
        Alamofire.request("http://lcboapi.com/stores").responseJSON {
            (response) in
            switch response.result {
            case .success(let value):
                self.parseData(data: JSON(value))
            case .failure(let error):
                print("got an error!!")
                print(error)
            }
        }
    }
    
    func parseData(data: JSON) {
        let locationList = data["result"].arrayValue
        for locationData in locationList {
            let location = Location(lat: locationData["latitude"].doubleValue,
                                    long: locationData["longitude"].doubleValue,
                                    name: locationData["name"].stringValue)
            listOfLocations.append(location)
        }
        locationsTable.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationsTable.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        let location = listOfLocations[indexPath.row]
        cell.nameLabel.text = location.name
        cell.longLabel.text = "Longtitude: " + String(location.coordinate.longitude)
        cell.latLabel.text = "Latitude: " + String(location.coordinate.latitude)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MapViewController {
            vc.listOfLocations = self.listOfLocations
        }  
    }
}

