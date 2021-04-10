//
//  DBUtilities.swift
//  ClassOrganiser
//  Utilities for the Database
//  Created by Deven Pile on 4/5/21.
//

import Foundation
import Firebase
import os.log

class DBUtilities{
    
    
    //MARK: - Add New Class
    //Adds new class to user
    static func addUserClass(newClass:UserClass) -> String?{
        let db = Firestore.firestore()
        var docId:String?
        guard let uid = Auth.auth().currentUser?.uid else{
            return "Unable to get UID"
        }
        let storageRef = Storage.storage().reference().child("images")
        let fileName = UUID().uuidString
        let compressedImage = newClass.classImage?.compressTo(5)
        guard let imageData = compressedImage?.jpegData(compressionQuality: 1) else {return nil}
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        let uploadTask = storageRef.child(uid).child(fileName).putData(imageData, metadata: metaData)
        uploadTask.observe( .success) { (snapshot) in
            os_log("ADD NEW: Upload Success")
        }
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (user, error) in
            if error == nil && user != nil{
                docId = user?.documents[0].documentID
                db.collection("users").document(docId!).collection("classes").addDocument(data: [Constants.Database.NAME:newClass.className,
                                                                                                 Constants.Database.DESC:newClass.className,
                                                                                                 Constants.Database.COLOR:newClass.getColorAsString(),
                                                                                                 Constants.Database.LINK:newClass.classLink,
                                                                                                 Constants.Database.LOCATION:newClass.location,
                                                                                                 Constants.Database.IMG:fileName,
                                                                                                 Constants.Database.MEETING:newClass.classMeetingTime]) { (error) in
                    if error == nil {
                        os_log("ADD NEW: Class Added")
                    }
                    else{
                        os_log("ADD NEW: \(String(describing: error))")
                    }
                }
            }
        }
        return nil
    }
    
    //MARK: - Update Class
    //Updates specified user class in the database
    static func updateClass(toUpdate:UserClass){
        let className = toUpdate.className
        let db = Firestore.firestore()
        var docId:String?
        var classDocId:String?
        guard let uid = Auth.auth().currentUser?.uid else{
            os_log("UPDATE: Unable to get UID")
            return
        }
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (userDoc, error) in
            if error == nil && userDoc != nil {
                docId = userDoc!.documents[0].documentID
                db.collection("users").document(docId!).collection("classes").whereField("class_name", isEqualTo: className).getDocuments { (classDoc, error) in
                    if error == nil && classDoc != nil{
                        classDocId = classDoc!.documents[0].documentID
                        db.collection("users").document(docId!).collection("classes").document(classDocId!).updateData([Constants.Database.DESC:toUpdate.classDescription,
                                                                                                                        Constants.Database.MEETING:toUpdate.classMeetingTime,
                                                                                                                        Constants.Database.LOCATION:toUpdate.location,
                                                                                                                        Constants.Database.LINK:toUpdate.classLink]) { (error) in
                            if error == nil{
                                os_log("UPDATE: Update Success")
                            }
                            else{
                                os_log("UPDATE: Update Fail")
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    //MARK: - Delete Class
    //Deletes class from user 
    static func deleteClass(toRemove:String){

        var docId:String?
        var classDocId:String?
        var imageString:String?
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else{
            os_log("DELETE: Unable to get UID")
            return
        }
        let storageRef = Storage.storage().reference().child("images")
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (user, err) in
            if err == nil && user != nil{
                docId = user?.documents[0].documentID
                db.collection("users").document(docId!).collection("classes").whereField("class_name", isEqualTo: toRemove).getDocuments { (userClass, err) in
                    if err == nil && userClass != nil{
                        classDocId = userClass?.documents[0].documentID
                        let data = userClass!.documents[0].data()
                        imageString = (data["class_img"] as! String)
                        storageRef.child(uid).child(imageString!).delete { (err) in
                            if err == nil{
                                os_log("DELETE: Image Deleted")
                            }
                            else{
                                os_log("DELETE: \(String(describing: err))")
                            }
                        }
                    }
                }
            }
        }
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (user, err) in
            if err == nil && user != nil{
                docId = user?.documents[0].documentID
                db.collection("users").document(docId!).collection("classes").whereField("class_name", isEqualTo: toRemove).getDocuments { (userClass, err) in
                    if err == nil && userClass != nil{
                        classDocId = userClass?.documents[0].documentID
                        db.collection("users").document(docId!).collection("classes").document(classDocId!).delete { (error) in
                            if err == nil{
                                os_log("DELETE CLASS: Deleted class successfully")
                            }
                            else{
                                os_log("DELETE: \(String(describing: err))")
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    //MARK: - Upload Image
    
    func uploadImage(image: UIImage, completion:@escaping((String?) -> () )){
        guard let uid = Auth.auth().currentUser?.uid else {
            os_log("UPLOAD IMAGE: Unable to get UID")
            return
        }
        
        let storageRef = Storage.storage().reference().child("images")
        let fileName = GeneralUtilities.randomString(length: 20)
        let compressedImage = image.compressTo(1)
        guard let imageData = compressedImage?.jpegData(compressionQuality: 0.1) else {completion(nil); return}
        let metaData = StorageMetadata()
        metaData.contentType = "img/jpg"
        
        storageRef.child(uid).child(fileName).putData(imageData, metadata: metaData) { (metaData, error) in
            guard let metaData = metaData else{
                return
            }
            metaData.contentType = "image/jpg"
            storageRef.downloadURL { (url, error) in
                guard let imageUrl = url else{
                    completion(nil)
                    os_log("UPLOAD IMAGE: ERROR Completed nil")
                    return
                }
                let imgUrlString = imageUrl.absoluteString
                os_log("UPLOAD IMAGE: Upload Complete")
                completion(imgUrlString)
            }
        }
        
        
    }
    
}



