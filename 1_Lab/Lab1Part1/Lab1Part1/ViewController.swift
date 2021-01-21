//
//  ViewController.swift
//  Lab1Part1
//
//  Created by Deven Pile on 1/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var BMIOutput: UILabel!
    @IBOutlet weak var BMIColoredMessage: UILabel!
    
    var bmi:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BMIOutput.isHidden = true
        self.BMIColoredMessage.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateBMI(_ sender: Any) {
        let height = Double(heightInput.text!)
        let weight = Double(weightInput.text!)
        
        print(height)
        print(weight)
        
        //bmi = (weight!)/((height!)*(height!))*703
        bmi = ((weight!)/(height! * height!))*703
        
        
        print(bmi)
        self.BMIOutput.isHidden = false
        self.BMIColoredMessage.isHidden = false
        self.BMIOutput.text = "BMI: \(bmi)"
        
        if bmi < 18 {
            self.BMIColoredMessage.text = "You are underweight"
            self.BMIColoredMessage.textColor = UIColor.blue
        }
        else if bmi >= 18 && bmi < 25{
            self.BMIColoredMessage.text = "You are normal"
            self.BMIColoredMessage.textColor = UIColor.green
        }
        else if bmi >= 25 && bmi <= 30{
            self.BMIColoredMessage.text = "You are pre-obese"
            self.BMIColoredMessage.textColor = UIColor.purple
        }
        else{
            self.BMIColoredMessage.text = "You are Obese"
            self.BMIColoredMessage.textColor = UIColor.red
        }
        
        
        
        
        
        
    }
    
}

