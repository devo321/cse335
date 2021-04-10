//
//  ClassDetailViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/8/21.
//

import UIKit

protocol sendDataBack {
    func sendDataToClasses(thisClass:UserClass)
}

class ClassDetailViewController: UIViewController {

    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var classImg: UIImageView!
    @IBOutlet weak var classNameLbl: UILabel!
    @IBOutlet weak var classDescLbl: UILabel!
    @IBOutlet weak var classMeetingTimeLbl: UILabel!
    @IBOutlet weak var openClassTypeBtn: UIButton!
    @IBOutlet weak var locationAddrTITLE: UILabel!
    @IBOutlet weak var locationAddrLbl: UILabel!
    
    @IBOutlet weak var meetingTimeTITLE: UILabel!
    @IBOutlet weak var classLinkTITLE: UILabel!
    
    var thisClass:UserClass?
    var classes = [UserClass]()
    var classLinkString:String?
    var delegate:sendDataBack? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Set Values for View controller
    
    func setValues(){
        self.classImg.image = thisClass?.classImage
        self.classNameLbl.text = thisClass?.className
        self.classDescLbl.isHidden = true
        self.meetingTimeTITLE.isHidden = true
        self.classMeetingTimeLbl.isHidden = true
        self.classLinkTITLE.isHidden = true
        self.openClassTypeBtn.isHidden = true
        self.locationAddrTITLE.isHidden = true
        self.locationAddrLbl.isHidden = true
        //Check which fields user has, display them if they have them
        if thisClass?.location != ""{
            self.locationAddrLbl.isHidden = false
            self.locationAddrLbl.text = thisClass?.location
            self.locationAddrTITLE.isHidden = false
        }
        
        if thisClass?.classDescription != ""{
            self.classDescLbl.isHidden = false
            self.classDescLbl.text = thisClass?.classDescription
        }
        if thisClass?.classLink != "" {
            self.classLinkTITLE.isHidden = false
            self.openClassTypeBtn.isHidden = false
        }
        let meeting = GeneralUtilities.buildMeetingString(meetingTime: thisClass?.classMeetingTime ?? ["":""])
        if meeting != nil{
            self.meetingTimeTITLE.isHidden = false
            self.classMeetingTimeLbl.isHidden = false
            self.classMeetingTimeLbl.text = meeting
        }
        
        
    }
    
    //MARK: - Open Link
    //Opens class link in browser
    @IBAction func openClassBtnTapped(_ sender: Any) {
        if thisClass!.classLink.hasPrefix("https://") || thisClass!.classLink.hasPrefix("http://"){
            guard let url = URL(string: thisClass!.classLink)else{return}
            if #available(iOS 10, *){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.openURL(url)
            }
        }
        else{
            //Correct URL and try to open
            let correctedUrl = "https://\(thisClass!.classLink)"
            if UIApplication.shared.canOpenURL(URL(string: correctedUrl)!){
                UIApplication.shared.open(URL(string: correctedUrl)!, options: [:], completionHandler: nil)
            }
            else{
                let alert = UIAlertController(title: "Warning", message: "Unable to open link, Please update link and try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editView = segue.destination as? EditViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        editView.classesEdit = classes
        editView.thisClassEdit = thisClass
        
    }
}
