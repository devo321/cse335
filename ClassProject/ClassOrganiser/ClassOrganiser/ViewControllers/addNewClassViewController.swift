//
//  addNewClassViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/6/21.
//

import UIKit
import Firebase

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
    
    
    var activeTextField:UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        errorLbl.isHidden = true
        classNameTF.delegate = self
        //classAddressTF.delegate = self
        //classLinkTF.delegate = self
        updateAddButtonState()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Keyboard
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
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "You don't have permission to access the camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
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
            print("Class Image Success")
            newClass.printClass()
            let result = DBUtilities.addUserClass(newClass: newClass)
            print(String(describing: result))
        }
        else{
            let classImg = UIImage(named: "White-Square.jpg")
            let dictionary:[String:String] = ["class_day":classDay ?? "", "class_time":classTime ?? ""]
            let newClass = UserClass.init(name: className!, desc: classDesc ?? "", img: classImg!, color: "black", link: classLink ?? "", location: classAddr ?? "", meetingTime: dictionary)
            print("Class Image Fail")
            newClass.printClass()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addBtn.isEnabled = false
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
        updateAddButtonState()
    }
    

    
    
    //MARK: - Private Methods
    private func updateAddButtonState(){
        let text = classNameTF.text ?? ""
        addBtn.isEnabled = !text.isEmpty
    }
}
