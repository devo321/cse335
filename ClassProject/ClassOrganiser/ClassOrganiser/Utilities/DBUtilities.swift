//
//  DBUtilities.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/5/21.
//

import Foundation
import Firebase

class DBUtilities{
    
    static func addUserClass(newClass:UserClass) -> String?{
        var storeError:String?
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
            print("UPLOAD SUCCESS")
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
                        print("CLASS ADDED")
                    }
                    else{
                        print(String(describing: error))
                    }
                }
            }
        }
        return nil
    }
    
    func uploadImage(image: UIImage, completion:@escaping((String?) -> () )){
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Unable to get UID")
            return
        }
        
        let storageRef = Storage.storage().reference().child("images")
        let fileName = GeneralUtilities.randomString(length: 20)
        let compressedImage = image.compressTo(1)
        guard let imageData = compressedImage?.jpegData(compressionQuality: 1) else {completion(nil); return}
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
                    print("NIL COMPLETION")
                    return
                }
                let imgUrlString = imageUrl.absoluteString
                print("UPLOAD COMPLETE")
                completion(imgUrlString)
            }
        }
        
        
    }
    
}



