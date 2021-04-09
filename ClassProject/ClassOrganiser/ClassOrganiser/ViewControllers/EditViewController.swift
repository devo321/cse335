//
//  EditViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/9/21.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var classImg: UIImageView!
    @IBOutlet weak var classNameLbl: UILabel!
    @IBOutlet weak var classDescTF: UITextField!
    @IBOutlet weak var classDayTF: UITextField!
    @IBOutlet weak var classTimeTF: UITextField!
    @IBOutlet weak var classLocationTF: UITextField!
    @IBOutlet weak var classLinkTF: UITextField!
    
    
    var thisClassEdit:UserClass?
    var rtnClass:UserClass?
    var classesEdit = [UserClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.errorLbl.isHidden = true
        setValues()
        // Do any additional setup after loading the view.
    }
    
    func setValues(){
        self.classImg.image = thisClassEdit?.classImage
        self.classNameLbl.text = thisClassEdit?.className
        self.classDescTF.text = thisClassEdit?.classDescription
        self.classDayTF.text = thisClassEdit?.classMeetingTime["class_day"]
        self.classTimeTF.text = thisClassEdit?.classMeetingTime["class_time"]
        self.classLocationTF.text = thisClassEdit?.location
        self.classLinkTF.text = thisClassEdit?.classLink
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let button = sender as? UIBarButtonItem, button == saveBtn else {
            print("Save Not pressed, Cancelling")
            return
        }
        thisClassEdit?.classDescription = self.classDescTF.text ?? ""
        let dictionary:[String:String] = ["class_day":classDayTF.text ?? "", "class_time":classTimeTF.text ?? ""]
        thisClassEdit?.classMeetingTime = dictionary
        thisClassEdit?.location = self.classLocationTF.text ?? ""
        thisClassEdit?.classLink = self.classLinkTF.text ?? ""
        rtnClass = thisClassEdit
        
        
        
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
    }
    
    
    //MARK: - Keyboard
    //These functions move the keyboard around
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 200
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
