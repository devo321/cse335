//
//  SignUpViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/2/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signUpBTN: UIButton!
    
    @IBOutlet weak var errorLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements(){
        errorLBL.isHidden = true
        //Do additional styling here
        
    }
    

    
    //MARK: - Sign up new user

    
    @IBAction func signUpTapped(_ sender: Any) {
        //Validate fields
        let error = AuthUtilities.validateFields(firstName: firstNameTF.text!, lastName: lastNameTF.text!, email: emailTF.text!, pass: passwordTF.text!)
        
        if error != nil {
            //Something is wrong
            self.showError(error!)
        }
        else{
            //Create cleaned data
            let firstName = firstNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create User
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil{
                    //Error creating a user
                    self.showError("Error Creating User")
                }
                else{
                    //User created, Store first and last name
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["first_name":firstName,"last_name":lastName, "uid":result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("Couldnt add user data")
                        }
                    }
                    //Transition to home Screen
                    self.transitionToHome()
                    
                }
            }
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    //Sets storyboard entry point to table view
    func transitionToHome(){
        let homeView = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)
        view.window?.rootViewController = homeView
        view.window?.makeKeyAndVisible()
    }
    
    
    //MARK: - Error Handling
    //Shows error if there is one
    func showError(_ message:String){
        errorLBL.text = message
        errorLBL.isHidden = false
    }
    

}
