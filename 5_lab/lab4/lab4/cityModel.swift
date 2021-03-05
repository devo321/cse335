//
//  cityModel.swift
//  lab4
//
//  Created by Deven Pile on 2/22/21.
//

import Foundation
import UIKit
import CoreData

class cityModel{
    let managedObjectContext:NSManagedObjectContext?
    init(context:NSManagedObjectContext){
        managedObjectContext = context
    }
    
    func saveContext(name:String, desc:String){
        let ent = NSEntityDescription.entity(forEntityName: "City", in: self.managedObjectContext!)
        let city = City(entity: ent!, insertInto: managedObjectContext)
        
        city.name = name
        city.desc = desc
        
        do{
            try managedObjectContext?.save()
            print("Success")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func remove(item: NSManagedObject){
        managedObjectContext?.delete(item)
        
        do{
            try managedObjectContext?.save()
            print("Success")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func saveImg(insertCity: City, img: UIImage){
        insertCity.image = img.pngData()! as Data
        do{
            try managedObjectContext?.save()
        }catch{
            print("Error While Saving")
        }
    }
}
