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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLbl.isHidden = true
        classNameTF.delegate = self
        updateAddButtonState()
        // Do any additional setup after loading the view.
    }
    
    
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
    
    
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addBtn.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateAddButtonState()
    }
    
    
    //MARK: - Private Methods
    private func updateAddButtonState(){
        let text = classNameTF.text ?? ""
        addBtn.isEnabled = !text.isEmpty
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
