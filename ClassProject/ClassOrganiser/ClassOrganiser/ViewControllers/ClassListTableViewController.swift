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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserClasses()
        
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

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(indexPath.row)
            userClasses[indexPath.row].printClass()
            let toDeleteString = userClasses[indexPath.row].className
            DBUtilities.deleteClass(toRemove: toDeleteString)
            userClasses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }    
    }
    

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
    
    @IBAction func unwindToClassList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? addNewClassViewController, let newClass = sourceViewController.rtnClass {
            let newIndexPath = IndexPath(row: userClasses.count, section: 0)
            userClasses.append(newClass)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
    
    
    
    func getUserClasses(){
        let pending = UIAlertController(title: "Loading Classes\n\n\n", message: nil, preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: pending.view.bounds)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pending.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()

        self.present(pending, animated: true, completion: nil)
        
        let db = Firestore.firestore()
        var docId:String?
        var counter:Int = 0
        
        
        guard let uid = Auth.auth().currentUser?.uid else{return}
        db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                docId = (snapshot?.documents[0].documentID)!
                db.collection("users").document(docId!).collection("classes").getDocuments { (querySnap, error) in
                    if error == nil  && querySnap != nil {
                        var imageData: UIImage?
                        for doc in querySnap!.documents{
                            let data = doc.data()
                            let user = UserClass(name: data["class_name"] as! String,
                                                       desc: data["class_desc"] as! String,
                                                       img: UIImage(named: "White-Square.jpg")!,
                                                       color: data["class_color"] as! String,
                                                       link: data["class_link"] as! String,
                                                       location: data["class_location"] as! String,
                                                       meetingTime: data["meeting_time"] as! Dictionary<String,String>)
                            self.userClasses.append(user)
                            let fileName = data["class_img"] as! String
                            print(fileName)
                            let pathString = "images/" + uid + "/" + fileName
                            let pathRefrence = Storage.storage().reference(withPath: pathString)
                            let downloadTask = pathRefrence.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
                                if let error = error {
                                    //Error!
                                    print(error.localizedDescription)
                                }
                                else{
                                    imageData = UIImage(data: data!)
                                    user.classImage = imageData
                                    self.tableView.reloadData()
                                }
                            }
                            downloadTask.observe(.success) { (snap) in
                                counter += 1
                                if counter == self.userClasses.count{
                                    pending.dismiss(animated: true, completion: nil)
                                }
                                self.tableView.reloadData()
                            }
                            if counter == self.userClasses.count{
                                downloadTask.removeAllObservers()
                            }
                        }
                    
                    }
                }
            }
        }
        
    }
}



