//
//  ViewController.swift
//  lab7
//
//  Created by Deven Pile on 3/25/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var biggestMag: UILabel!
    @IBOutlet weak var biggestDate: UILabel!
    @IBOutlet weak var biggestDepth: UILabel!
    
    @IBOutlet weak var recentMag: UILabel!
    @IBOutlet weak var recentDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hide labels
        self.biggestMag.isHidden = true
        self.biggestDate.isHidden = true
        self.biggestDepth.isHidden = true
        self.recentMag.isHidden = true
        self.recentDate.isHidden = true
        
    }


    @IBAction func searchBtn(_ sender: Any) {
        var long:Double = 0
        var lat:Double = 0
        _ = CLGeocoder()
        let searchString = searchBar.text!
        CLGeocoder().geocodeAddressString(searchString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    
                    long = coords.longitude
                    lat = coords.latitude
                    self.getJSONData(long: lat, lat: long)
                    
                   
                }
        })
    }
    
    func getJSONData(long:Double, lat:Double){
        let north:String = String(long + 10)
        let south:String = String(long - 10)
        let east:String = String(lat + 10)
        let west:String = String(lat - 10)
        let apiUrl = "http://api.geonames.org/earthquakesJSON?north="+north+"&south="+south+"&east="+east+"&west="+west+"&username=devo321"
        let url = URL(string: apiUrl)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            //print(jsonResult)
            
            var mag:NSArray = jsonResult["earthquakes"] as! NSArray
            DispatchQueue.main.async
                {
                self.setBiggest(mag: mag)
                self.setMostRecent(mag: mag)
            }
        })
        jsonQuery.resume()
        
    }
    
    func setBiggest(mag:NSArray){
        var biggest:Double = 0
        var date:String = "null"
        var depth:Int = 0
        
        for x in mag{
            let y = x as? [String:AnyObject]
            if(y!["magnitude"] as! Double > biggest){
                biggest = y!["magnitude"] as! Double
                date = y!["datetime"] as! String
                depth = y!["depth"] as! Int
            }
        }
        self.biggestMag.text = String(biggest)
        self.biggestDepth.text = String(depth)
        self.biggestDate.text = date
        self.biggestMag.isHidden = false
        self.biggestDepth.isHidden = false
        self.biggestDate.isHidden = false
    }
    
    func setMostRecent(mag:NSArray){
        var dict:[String:Double] = [:]
        var dates:[String] = []
        var mags:[Double] = []
        for x in mag{
            let y = x as? [String:AnyObject]
            dict[y!["datetime"]?.substring(to: 10) as! String] = y!["magnitude"] as! Double
            dates.append(y!["datetime"]?.substring(to: 10) as! String)
            mags.append(y!["magnitude"] as! Double)
        }
        
        let sortedDict = dict.sorted(by: >)
        let d:Double! = sortedDict.first?.value
        self.recentDate.text = sortedDict.first?.key
        self.recentMag.text = String(d)
        self.recentDate.isHidden = false
        self.recentMag.isHidden = false
        
    }
    
}

