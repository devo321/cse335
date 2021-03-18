//
//  DetailViewController.swift
//  lab4
//
//  Created by Deven Pile on 2/22/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    var selectedCity:String?
    var latitude:String?
    var longitude:String?
    var flag:Bool = false
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapTypePicker: UISegmentedControl!
    @IBOutlet weak var searchText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityName.text = selectedCity
        if(selectedCity == "Wellington"){
            selectedCity = "Wellington New Zealand"
        }
        if(selectedCity == "London"){
            selectedCity = "London England"
        }
        showLocation(location: selectedCity!)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!
    
    @IBAction func mapType(_ sender: Any) {
        
        switch(mapTypePicker.selectedSegmentIndex){
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
    
    
    func showLocation(location:String){
        _ = CLGeocoder()
        CLGeocoder().geocodeAddressString(location, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    _ = location!.coordinate
                    print(location)
                   
                    let cityLocation:CLLocation = location!
                    self.lat.text = String(cityLocation.coordinate.latitude)
                    self.long.text = String(cityLocation.coordinate.longitude)
                    
                    let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.mapView.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.name
                    ani.subtitle = placemark.subLocality
                    
                    self.mapView.addAnnotation(ani)
                    
                   
                }
        })
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        if(flag){
            mapView.removeAnnotations(mapView.annotations)
        }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchText.text
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print( response.mapItems )
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                let annotation = MKPointAnnotation()
                annotation.coordinate = place.coordinate
                annotation.title = place.name
                self.mapView.addAnnotation(annotation)

                
            }
            self.flag = true;
           
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

