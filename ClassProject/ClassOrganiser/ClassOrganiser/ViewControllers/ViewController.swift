//
//  ViewController.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpBTN: UIButton!
    @IBOutlet weak var logInBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //setUpElements()
    }
    
    func setUpElements(){
        //For later styling
    }
    
    
    //MARK: -Navigation
    //Used to take user back to main screen from Login/Sign up views
    @IBAction func unwindToInitalView(sender: UIStoryboardSegue){
        
    }
    
    

}
