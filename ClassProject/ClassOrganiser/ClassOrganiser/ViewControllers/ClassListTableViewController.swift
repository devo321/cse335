//
//  ClassListTableViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/5/21.
//

import UIKit
import Firebase
import os.log


class ClassListTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserClasses()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedClasses.sharedInstance.classArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ClassCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ClassTableViewCell else{
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        //Configure the cell
        let thisClass = SharedClasses.sharedInstance.classArray[indexPath.row]
        cell.classNameLbl.text = thisClass.className
        cell.classMeetingTimeLbl.text = GeneralUtilities.buildMeetingString(meetingTime: thisClass.classMeetingTime)
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
            let toDeleteString = SharedClasses.sharedInstance.classArray[indexPath.row].className//userClasses[indexPath.row].className
            DBUtilities.deleteClass(toRemove: toDeleteString)
            SharedClasses.sharedInstance.classArray.remove(at: indexPath.row)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        //Determine which destination user is going to
        switch(segue.identifier ?? ""){
        //Detail view
        case "ShowDetail":
            guard let detailView = segue.destination as? ClassDetailViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedClassCell = sender as? ClassTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedClassCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedClass = SharedClasses.sharedInstance.classArray[indexPath.row]//userClasses[indexPath.row]
            detailView.thisClass = selectedClass
            detailView.classes = SharedClasses.sharedInstance.classArray//userClasses
        //Add New class view
        case "AddClass":
            guard let navController = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let childVC = navController.topViewController as? addNewClassViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            childVC.classes = SharedClasses.sharedInstance.classArray //userClasses
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
    }
    //Unwind segue
    @IBAction func unwindToClassList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? addNewClassViewController, let newClass = sourceViewController.rtnClass {
            let newIndexPath = IndexPath(row: SharedClasses.sharedInstance.classArray.count/*userClasses.count*/, section: 0)
            //userClasses.append(newClass)
            SharedClasses.sharedInstance.classArray.append(newClass)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        if let sourceViewController = sender.source as? EditViewController, let updatedClass = sourceViewController.thisClassEdit{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //userClasses[selectedIndexPath.row] = updatedClass
                SharedClasses.sharedInstance.classArray[selectedIndexPath.row] = updatedClass
            }
        }
    }
    //Check if this view has appeared, reload table view
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    //MARK: - Initial Load
    
    //Get user classes from database
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
                db.collection("users").document(docId!)
                db.collection("users").document(docId!).collection("classes").getDocuments { (querySnap, error) in
                    if error == nil  && querySnap != nil{
                        if querySnap!.isEmpty != true{
                            var imageData: UIImage?
                            for doc in querySnap!.documents{
                                let data = doc.data()
                                let user = UserClass(name: data[Constants.Database.NAME] as! String,
                                                     desc: data[Constants.Database.DESC] as! String,
                                                           img: UIImage(named: "White-Square.jpg")!,
                                                           color: data[Constants.Database.COLOR] as! String,
                                                           link: data[Constants.Database.LINK] as! String,
                                                           location: data[Constants.Database.LOCATION] as! String,
                                                           meetingTime: data[Constants.Database.MEETING] as! Dictionary<String,String>)
                                SharedClasses.sharedInstance.classArray.append(user)
                                let fileName = data["class_img"] as! String
                                let pathString = "images/" + uid + "/" + fileName
                                let pathRefrence = Storage.storage().reference(withPath: pathString)
                                if SharedClasses.sharedInstance.classArray.count > 0{
                                    
                                }
                                let downloadTask = pathRefrence.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
                                    if error != nil {
                                        //Error!
                                        os_log("GET USER CLASS: Error downloading class image")
                                    }
                                    else{
                                        imageData = UIImage(data: data!)
                                        user.classImage = imageData
                                        self.tableView.reloadData()
                                    }
                                }
                                downloadTask.observe(.success) { (snap) in
                                    counter += 1
                                    if counter == SharedClasses.sharedInstance.classArray.count/*self.userClasses.count*/{
                                        pending.dismiss(animated: true, completion: nil)
                                    }
                                    self.tableView.reloadData()
                                }
                                if counter == SharedClasses.sharedInstance.classArray.count/*self.userClasses.count*/{
                                    downloadTask.removeAllObservers()
                                }
                            }
                        }
                        else{
                            pending.dismiss(animated: true, completion: nil)
                        }
                    }            
                }
            }
        }
    }
}



