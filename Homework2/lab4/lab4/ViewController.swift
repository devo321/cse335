//
//  ViewController.swift
//  lab4
//
//  Created by Deven Pile on 2/22/21.
//

import UIKit
import CoreData

class ViewController: UIViewController,
                      UITableViewDataSource,
                      UITableViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    @IBOutlet weak var cityTable: UITableView!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var c:cityModel?
    
    var fetchResults = [City]()
    var tempIndex = 0

    
    func fetchRecord() -> Int{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        var x = 0
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [City])!
        
        x = fetchResults.count
        return x
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c = cityModel(context: managedObjectContext)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Picture", style: .default){ (action) in
            let name = alertController.textFields!.first!.text!
            let desc = alertController.textFields!.last!.text!
            print("HERE")
            let photoPicker = UIImagePickerController()
            photoPicker.delegate = self
            photoPicker.sourceType = .photoLibrary
            self.present(photoPicker, animated: true, completion: nil)
            self.c?.saveContext(name: name, desc: desc)
            self.tempIndex = self.fetchResults.endIndex
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
        return fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTable.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.layer.borderWidth = 1.0
        cell.textLabel?.text = fetchResults[indexPath.row].name
        if let picture = fetchResults[indexPath.row].image{
            cell.imageView?.image = UIImage(data: picture)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
    //    if editingStyle == .delete {
    //        self.c?.remove(item: fetchResults[indexPath.row])
    //        fetchResults.remove(at: indexPath.row)
    //        self.cityTable.reloadData()
    //    }
    //}
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Action 1
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: {(action, indexPath) in
            
            let alertController = UIAlertController(title: "Edit City", message: "", preferredStyle: .alert)
            let addAction = UIAlertAction(title: "Picture", style: .default){ (action) in
                let desc = alertController.textFields!.first!.text!
                print("HERE")
                let photoPicker = UIImagePickerController()
                photoPicker.delegate = self
                photoPicker.sourceType = .photoLibrary
                self.present(photoPicker, animated: true, completion: nil)
                self.tempIndex = indexPath.row
                self.c?.update(updateCity: self.fetchResults[indexPath.row], desc: desc);
                self.cityTable.reloadData()
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "City Description"
                textField.keyboardType = .default
            }
            
            
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        })
        editAction.backgroundColor = UIColor.blue
        
        //Action 2
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(action, indexPath) in
            self.c?.remove(item: self.fetchResults[indexPath.row])
            self.fetchResults.remove(at: indexPath.row)
            self.cityTable.reloadData()
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction,deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let name = fetchResults[selectedIndex.row].name
        let desc = fetchResults[selectedIndex.row].desc
        let img = fetchResults[selectedIndex.row].image
        
        if(segue.identifier == "detail"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedCity = name
                viewController.selectedDesc = desc
                if(img != nil){
                    viewController.selectedImg = UIImage(data: img!)
                }
                
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker .dismiss(animated: true, completion: nil)
        
        if let _ = fetchResults.last, let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.c?.saveImg(insertCity: fetchResults[tempIndex], img: img)
            
        }
        self.cityTable.reloadData()
    }
    
    func updateLastRow() {
        let indexPath = IndexPath(row: fetchResults.count - 1, section: 0)
        cityTable.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}

