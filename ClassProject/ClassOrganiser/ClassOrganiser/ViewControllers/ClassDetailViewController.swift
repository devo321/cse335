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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editView = segue.destination as? EditViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        editView.classesEdit = classes
        editView.thisClassEdit = thisClass
        
    }
    @IBAction func unwindToDetailView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EditViewController {
            thisClass = sourceViewController.rtnClass
            setValues()
        }
    }
    override func willMove(toParent parent: UIViewController?) {
        if !(parent?.isEqual(self.parent) ?? false) {
            print("DIDMOVE")
            if self.delegate != nil{
                let data = thisClass!
                if super.isViewLoaded{
                    self.delegate?.sendDataToClasses(thisClass: data)
                }
                
            }
        }
        //super.didMove(toParent: parent)
    }



}
