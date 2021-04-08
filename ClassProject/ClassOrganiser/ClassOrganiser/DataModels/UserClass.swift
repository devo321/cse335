//
//  UserClass.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/5/21.
//

import Foundation
import FirebaseFirestore
import UIKit


class UserClass{
    var className:String
    var classDescription:String
    var classImage:UIImage?
    private var classColor:String
    var classLink:String
    var location:String
    var classMeetingTime = Dictionary<String,String>()

    
    init(name:String, desc:String, img:UIImage, color:String, link:String, location:String, meetingTime:Dictionary<String,String>) {
        //let colorString = color
        self.className = name
        self.classDescription = desc
        self.classImage = img
        self.classColor = color
        self.classLink = link
        self.location = location
        self.classMeetingTime = meetingTime
    }
    /*
    convenience init?(name:String) {
        if name.isEmpty {
            return nil
        }
        //self.init(name: name, desc: "", img:UIImage(named: "White-Square.jpg")!, color:"black", link:"", location:GeoPoint.init(latitude: 0.0, longitude: 0.0), meetingTime:["nil":"nil"])
    }*/
    
    
    func getColor() -> UIColor{
        let color = self.classColor.lowercased()
        switch color {
        case "red":
            return UIColor.red
        case "blue":
            return UIColor.blue
        case "green":
            return UIColor.green
        case "gray":
            return UIColor.gray
        case "purple":
            return UIColor.purple
        default:
            return UIColor.black
        }
        //Finish other color types
    }
    
    func getColorAsString() -> String{
        return self.classColor
    }
    
    
    func printClass(){
        print("Name: " + self.className)
        print("Desc: " + self.classDescription)
        print("Color: " + self.classColor)
        print("Link: " + self.classLink)
        print("Location: " + self.location)
        print("Meeting Time:")
        print(self.classMeetingTime)
    }

    
    
    
}
