//
//  LogInViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/2/21.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var logInBTN: UIButton!
    @IBOutlet weak var errorLBL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLBL.isHidden = true
        //Do additional styling here
    }

    

   //MARK: - Log in User
    
    @IBAction func logInTapped(_ sender: Any) {
        //Validate Text fields
        let error = AuthUtilities.validateFields(email: emailTF.text!, password: passwordTF.text!)
        if error != nil{
            showError(error!)
        }
        else{
            //Create cleaned strings
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //Try to sign in user
            Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
                if error != nil {
                    self.errorLBL.text = error!.localizedDescription
                    self.errorLBL.isHidden = false
                }
                else{
                    self.transitionToHome()
                }
            }
        }
        
        
        //Sign in user
    }
    
    func showError(_ message:String){
        errorLBL.text = message
        errorLBL.isHidden = false
    }
    
    
    // MARK: - Navigation
    
    func transitionToHome(){
        let homeView = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)
        //let homeView = storyboard?.instantiateViewController(identifier: "test")
        view.window?.rootViewController = homeView
        view.window?.makeKeyAndVisible()
    }
    

}
