//
//  MapViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/9/21.
//

import UIKit
import MapKit
import SwiftyJSON
import os.log


class MapViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapTypePicker: UISegmentedControl!
    @IBOutlet weak var tempDisplay: UILabel!
    var locManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Using viewDidAppear to load map, allows map to be updated with new class data
    }
    //MARK: - Map Functions
    //Sets up map
    func setupMap(){
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        
        switch(locManager.authorizationStatus){
        case .restricted:
            os_log("Location access restricted")
        case .authorizedWhenInUse:
            currentLocation = locManager.location
            
        case .authorizedAlways:
            currentLocation = locManager.location
        default:
            return
        }
        
        if currentLocation != nil{
            let viewRegion = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(.follow, animated: true)
            mapView.setRegion(viewRegion, animated: true)
        }
        DispatchQueue.main.async {
            self.locManager.startUpdatingLocation()
        }
        //Place class placemarks
        putPlacemarks()
        //Get weather for user current location
        getWeatherJSON(coordinates: currentLocation.coordinate)
    }
    
    //Place class locations on map
    func putPlacemarks(){
        let request = MKLocalSearch.Request()
        
        for userClass in SharedClasses.sharedInstance.classArray{
            if userClass.location != ""{
                request.naturalLanguageQuery = userClass.location
                request.region = mapView.region
                let search = MKLocalSearch(request: request)
                search.start { (response, error) in
                    guard let response = response else{
                        return
                    }
                    var matchingItems = [MKMapItem]()
                    matchingItems = response.mapItems
                    let place = matchingItems[0].placemark
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = place.coordinate
                    annotation.title = place.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    //Change map type using Segmentmented Control
    @IBAction func selectMapType(_ sender: Any) {
        switch mapTypePicker.selectedSegmentIndex {
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = MKMapType.satellite
        case 2:
            mapView.mapType = MKMapType.hybrid
        default:
            mapView.mapType = MKMapType.standard
        }
    }
    
    //MARK: - Get Weather (JSON)
    //Gets weather of current location using an API JSON call
    func getWeatherJSON(coordinates:CLLocationCoordinate2D){
        let north = coordinates.latitude + 3
        let south = coordinates.latitude - 3
        let east = coordinates.longitude + 3
        let west = coordinates.longitude - 3
        let apiUrl = "http://api.geonames.org/weatherJSON?north=\(String(north))&south=\(String(south))&east=\(String(east))&west=\(String(west))&username=devo321"
        let url = URL(string: apiUrl)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do{
                guard let data = data else{
                    os_log("MAPVIEW: Error with URL Session")
                    return
                }
                if let json = try? JSON(data: data){
                    let temp = json["weatherObservations"].arrayValue[0]["temperature"].stringValue
                    let degF = (Float(temp)! * 1.8) + 32
                    DispatchQueue.main.async {
                        self.tempDisplay.text = String(Int(degF)) + "°"
                    }
                }
                else{
                    os_log("MAPVIEW: Error parsing JSON")
                }
            }
        }.resume()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMap()
        os_log("Map Loaded")
    }
}
