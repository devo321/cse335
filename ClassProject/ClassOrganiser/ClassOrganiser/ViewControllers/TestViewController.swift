//
//  TestViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/2/21.
//

import UIKit
import Firebase

class TestViewController: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.isHidden = true
        getUserData()
        // Do any additional setup after loading the view.
    }
    
    func getUserData(){
        var docId:String = ""
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (userData, error) in
            if error == nil && userData != nil{
                docId = userData!.documents[0].documentID
                for doc in userData!.documents{
                    let documentData = doc.data()
                    self.firstName.text = documentData["first_name"] as! String
                    self.lastName.text = documentData["last_name"] as! String
                }
                db.collection("users").document(docId).collection("classes").getDocuments { (classData, error) in
                    if error == nil && classData != nil{
                        for classInfo in classData!.documents{
                            let documentData = classInfo.data()
                            self.className.text = documentData["class_name"] as! String
                            self.desc.text = documentData["class_desc"] as! String
                            let meetingTime = documentData["meeting_time"] as! Dictionary<String, String>
                            self.meetingTime.text = meetingTime["class_day"]! + " at " + meetingTime["class_time"]!
                        }
                    }
                }
            }
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
