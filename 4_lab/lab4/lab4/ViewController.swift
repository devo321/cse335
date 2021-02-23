//
//  ViewController.swift
//  lab4
//
//  Created by Deven Pile on 2/22/21.
//

import UIKit

class ViewController: UIViewController,
                      UITableViewDataSource,
                      UITableViewDelegate{
    
    @IBOutlet weak var cityTable: UITableView!
    
    var cities:cityModel = cityModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default){ (action) in
            let name = alertController.textFields!.first!.text!
            let desc = alertController.textFields!.last!.text!
            self.cities.addCity(city: name, d: desc)
            self.cityTable.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "City Name"
            textField.keyboardType = .default
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "City Description"
            textField.keyboardType = .default
        }
        
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTable.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = cities.getCityName(i: indexPath.row)
        cell.imageView?.image = cities.getCityImg(i: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            cities.removeCity(index: indexPath.row)
            cityTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let name = cities.getCityName(i: selectedIndex.row)
        let desc = cities.getCityDesc(i: selectedIndex.row)
        let img = cities.getCityImg(i: selectedIndex.row)
        
        if(segue.identifier == "detail"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedCity = name
                viewController.selectedDesc = desc
                viewController.selectedImg = img
            }
        }
    }
    


}

