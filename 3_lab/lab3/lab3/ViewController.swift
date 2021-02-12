//
//  ViewController.swift
//  lab3
//
//  Created by Deven Pile on 2/11/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTb: UITextField!
    @IBOutlet weak var genreTb: UITextField!
    @IBOutlet weak var ticketTb: UITextField!
    @IBOutlet weak var nameSearchTb: UITextField!
    @IBOutlet weak var genreSearchTb: UITextField!
    @IBOutlet weak var ticketSearchTb: UITextField!
    var i:Int = 0
    
    var movieInfoDictionary:movieDictionary = movieDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addRecord(_ sender: UIBarButtonItem) {
        if let name = nameTb.text, let genre = genreTb.text, let ticket = Float16(ticketTb.text!) {
            movieInfoDictionary.add(name, genre, ticket)
            
            self.nameTb.text = ""
            self.genreTb.text = ""
            self.ticketTb.text = ""
            
        }
        else{
            let alert = UIAlertController(title:"Data Input Error", message: "Data inputs are either empty or incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        i = 0
    }
    
    @IBAction func deleteRecord(_ sender: UIBarButtonItem) {
        if let dName = nameSearchTb.text{
            if(nameSearchTb.text!.isEmpty){
                let alert = UIAlertController(title: "Cannot Delete Record", message: "Please select or search for a record first", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            movieInfoDictionary.deleteRecord(s: dName)
            
        }
        else{
            let alert = UIAlertController(title: "Cannot Delete Record", message: "Please select or search for a record first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        i = 0
        self.nameSearchTb.text = ""
        self.genreSearchTb.text = ""
        self.ticketSearchTb.text = ""
    }
    
    @IBAction func searchRecords(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Search Record", message: "", preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Search", style: .default){ (action) in
            let text = alertController.textFields!.first!.text!
            
            if (!text.isEmpty){
                let name = text
                let searched = self.movieInfoDictionary.search(s: name)
                
                if let x = searched {
                    self.nameSearchTb.text = x.name
                    self.genreSearchTb.text = x.genre
                    self.ticketSearchTb.text = String(x.ticketPrice!)
                    
                }
                
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Movie Title"
            textField.keyboardType = .default
        }
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        i = 0
        
    }
    
    @IBAction func editRecords(_ sender: UIBarButtonItem) {
        if(movieInfoDictionary.movies.isEmpty){
            let alert = UIAlertController(title: "No Records Available", message: "Please add a record", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if(nameSearchTb.text!.isEmpty){
            let alert = UIAlertController(title: "No Record Selected", message: "Please select a record", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            let alertController = UIAlertController(title: "Edit Record", message: "", preferredStyle: .alert)
            let editAction = UIAlertAction(title:"Save", style: .default){ (action) in
                let text = alertController.textFields!.first!.text!
                
                if(!text.isEmpty){
                    let price = Float16(text)
                    let search = self.movieInfoDictionary.search(s: self.nameSearchTb.text!)
                    
                    if let x = search {
                        x.setPrice(price: price!)
                    }
                    self.nameSearchTb.text = ""
                    self.genreSearchTb.text = ""
                    self.ticketSearchTb.text = ""
                    
                }
                
            }
            let cancelAction = UIAlertAction(title:"Cancel", style: .cancel){(action) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "New Price"
                textField.keyboardType = .decimalPad
            }
            alertController.addAction(editAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            i = 0
        }
        //nameSearchTb.text = ""
        //genreSearchTb.text = ""
        //ticketSearchTb.text = ""
        
    }
     
    @IBAction func nextRecord(_ sender: UIBarButtonItem) {
        if(!movieInfoDictionary.movies.isEmpty){
            if(nameSearchTb.text!.isEmpty){
                display(index: 0)
            }
            else{
                //i = i + 1
                if(movieInfoDictionary.movies.endIndex - 1 > i){
                    i = i + 1
                    display(index: i)
                }
                else{
                    let alert = UIAlertController(title: "", message: "No More Records", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    i = 0
                }
            }
        }
        else{
            let alert = UIAlertController(title: "No Records Available", message: "Please add a record", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            i = 0
        }
    }
    
    @IBAction func prevRecord(_ sender: UIBarButtonItem) {
        if(!movieInfoDictionary.movies.isEmpty){
            if(nameSearchTb.text!.isEmpty){
                display(index: 0)
            }
            else{
                if( i > 0){
                    i = i - 1
                    display(index: i)
                }
                else{
                    let alert = UIAlertController(title: "", message: "Showing first record", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
        else{
            let alert = UIAlertController(title: "No Records Available", message: "Please add a record", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            i = 0
        }
        
    }
    
    func display(index:Int){
        nameSearchTb.text = movieInfoDictionary.movies[index].name
        genreSearchTb.text = movieInfoDictionary.movies[index].genre
        ticketSearchTb.text = String(movieInfoDictionary.movies[index].ticketPrice!)
    }
}



