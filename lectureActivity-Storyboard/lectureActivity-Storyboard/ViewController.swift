//
//  ViewController.swift
//  lectureActivity-Storyboard
//
//  Created by Deven Pile on 1/16/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.greeting.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func submitBtn(_ sender: Any) {
        let first = self.firstName.text!
        let last = self.lastName.text!
        
        print(first)
        print(last)
        
        self.greeting.text = "\(first) \(last) Welcome to CSE335"
        self.greeting.textColor = UIColor.blue
        self.greeting.isHidden = false
        
        
    }
    
}

