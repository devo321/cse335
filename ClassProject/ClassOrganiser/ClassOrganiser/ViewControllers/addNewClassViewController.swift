//
//  addNewClassViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/6/21.
//

import UIKit
import Firebase
import os.log

class addNewClassViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var classPhotoImg: UIImageView!
    @IBOutlet weak var classNameTF: UITextField!
    @IBOutlet weak var classDescTF: UITextField!
    @IBOutlet weak var classDayTF: UITextField!
    @IBOutlet weak var classTimeTF: UITextField!
    @IBOutlet weak var classAddressTF: UITextField!
    @IBOutlet weak var classLinkTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    
    var userImage:UIImage?
    var rtnClass:UserClass?
    var classes = [UserClass]()
    
    
    var activeTextField:UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        errorLbl.isHidden = true
        classNameTF.delegate = self
        updateAddButtonState()
    }
    
    //If user presses add button, set values up to return to table view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button == addBtn else {
            //Add not pressed, return to parent view
            return
        }
        let dictionary:[String:String] = ["class_day":classDayTF.text ?? "", "class_time":classTimeTF.text ?? ""]
        addBtnTapped((Any).self)
        
        rtnClass = UserClass(name: classNameTF.text ?? "" , desc: classDescTF.text ?? "" , img: classPhotoImg.image!, color: "black", link: classLinkTF.text ?? "", location: classAddressTF.text ?? "", meetingTime: dictionary)
    }
    
    
    //MARK: - Keyboard
    //Moves view so that each text field is accessable with the keyboard shown on screen
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
    
    //MARK: - Image Picker
    @IBAction func imageGestureTapped(_ sender: UITapGestureRecognizer) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    //Open camera
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "You don't have permission to access the camera or there is no camera available for this device. Please check privacy settings", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    //Open gallery
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "You don't have permission to access the gallery", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //get image from image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage{
            self.classPhotoImg.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Navigation Buttons
    
    @IBAction func addBtnTapped(_ sender: Any) {
        let className = self.classNameTF.text
        let classDesc = self.classDescTF.text
        let classDay = self.classDayTF.text
        let classTime = self.classTimeTF.text
        let classAddr = self.classAddressTF.text
        let classLink = self.classLinkTF.text
        if let classImg = self.classPhotoImg.image{
            let dictionary:[String:String] = ["class_day":classDay ?? "", "class_time":classTime ?? ""]
            let newClass = UserClass.init(name: className!, desc: classDesc ?? "", img: classImg, color: "black", link: classLink ?? "", location: classAddr ?? "", meetingTime: dictionary)
            os_log("ADD NEW CLASS: Image load Success")
            let result = DBUtilities.addUserClass(newClass: newClass)
            print(String(describing: result))
        }
        else{
            let classImg = UIImage(named: "White-Square.jpg")
            let dictionary:[String:String] = ["class_day":classDay ?? "", "class_time":classTime ?? ""]
            let newClass = UserClass.init(name: className!, desc: classDesc ?? "", img: classImg!, color: "black", link: classLink ?? "", location: classAddr ?? "", meetingTime: dictionary)
            newClass.printClass()
            os_log("ADD NEW CLASS: Class Image load fail")
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - UITextFieldDelegate
    //Check if user is editing a text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addBtn.isEnabled = false
        self.activeTextField = textField
    }
    //Check if user is done editing a text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
        updateAddButtonState()
    }
    

    
    
    //MARK: - Private Methods
    //Update if user can tap add button or not, based on values in text fields
    private func updateAddButtonState(){
        let text = classNameTF.text ?? ""
        print(text)
        if(text.isEmpty){
            errorLbl.isHidden = true
            addBtn.isEnabled = false
        }
        else if GeneralUtilities.isUniqueName(name: text, classes: classes) {
            errorLbl.isHidden = true
            addBtn.isEnabled = true
        }
        else{
            addBtn.isEnabled = false
            errorLbl.text = "Class name must be unique"
            errorLbl.isHidden = false
        }
    }
}
