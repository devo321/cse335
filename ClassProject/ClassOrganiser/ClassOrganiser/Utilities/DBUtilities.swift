//
//  DBUtilities.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/5/21.
//

import Foundation
import Firebase

class DBUtilities{
    
    /*
    static func getUserClasses() -> [UserClass]{
        var docId:String
        var retrievedClasses = [UserClass]()
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else{return retrievedClasses}
        db.collection("users").whereField("uid", isEqualTo: uid).addSnapshotListener { (querySnapshot, error) in
            if error == nil && querySnapshot != nil {
                let docId = querySnapshot?.documents[0].documentID
                db.collection("users").document(docId!).collection("classes").addSnapshotListener { (querySnap, error) in
                    guard let documents = querySnap?.documents else{print("No Classes");return}
                    var imageData:UIImage?
                    retrievedClasses = documents.map { (querySnap) -> UserClass in
                        let data = querySnap.data()
                        if let decodedData = Data(base64Encoded: data["class_img"] as! String, options: .ignoreUnknownCharacters){
                            imageData = UIImage(data: decodedData)
                        }
                        return UserClass.init(name: data["class_name"] as! String, desc: data["class_desc"] as! String, img: imageData!, color: data["class_color"] as! String, link: data["class_link"] as! String, location: data["class_location"] as! GeoPoint, meetingTime: data["meeting_time"] as! Dictionary<String,String>)
        
                    }
                    print(retrievedClasses[0].printClass())
                }
            }
        }
        return retrievedClasses
    }*/

    
    
}
