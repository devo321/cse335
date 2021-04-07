//
//  ClassListTableViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/5/21.
//

import UIKit
import Firebase


class ClassListTableViewController: UITableViewController {

    var userClasses = [UserClass]()
    var otherClasses = [UserClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserClasses()
        print(otherClasses.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userClasses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ClassCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ClassTableViewCell else{
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Configure the cell...
        let thisClass = userClasses[indexPath.row]
        cell.classNameLbl.text = thisClass.className
        cell.classMeetingTimeLbl.text = thisClass.classMeetingTime["class_day"]! + " at " + thisClass.classMeetingTime["class_time"]!
        cell.classImg.image = thisClass.classImage?.resizeImageWithBounds(bounds: CGSize.init(width: 80, height: 80))
        
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? ""){
        case "ShowDetail":
            guard let detailView = segue.destination as? DetailTestViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedClassCell = sender as? ClassTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedClassCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedClass = userClasses[indexPath.row]
            detailView.userClass = selectedClass
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
    }*/
    
    
    
    
    
    func getUserClasses(){
        let db = Firestore.firestore()
        var docId:String?
        guard let uid = Auth.auth().currentUser?.uid else{return}
        
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                docId = (snapshot?.documents[0].documentID)!
                db.collection("users").document(docId!).collection("classes").getDocuments { (querySnap, error) in
                    if error == nil  && querySnap != nil {
                        var imageData: UIImage?
                        for doc in querySnap!.documents{
                            let data = doc.data()
                            if let decodedData = Data(base64Encoded: data["class_img"] as! String, options: .ignoreUnknownCharacters) {
                                imageData = UIImage(data: decodedData)
                            }
                            let user = UserClass(name: data["class_name"] as! String,
                                                       desc: data["class_desc"] as! String,
                                                       img: imageData!,
                                                       color: data["class_color"] as! String,
                                                       link: data["class_link"] as! String,
                                                       location: data["class_location"] as! GeoPoint,
                                                       meetingTime: data["meeting_time"] as! Dictionary<String,String>)
                            self.userClasses.append(user)
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
}



