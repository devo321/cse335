//
//  ViewController.swift
//  Lab1Part2
//
//  Created by Deven Pile on 1/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HeightSlider: UISlider!
    @IBOutlet weak var WeightSlider: UISlider!
    @IBOutlet weak var HeightText: UILabel!
    @IBOutlet weak var WeightText: UILabel!
    @IBOutlet weak var BMIText: UILabel!
    @IBOutlet weak var BMIMessage: UILabel!
    
    var height:Float = 0
    var weight:Float = 0
    var bmi:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HeightText.isHidden = true
        self.WeightText.isHidden = true
        self.BMIText.isHidden = true
        self.BMIMessage.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func heightSliderChanged(_ sender: Any) {
        self.HeightText.text = "\(HeightSlider.value)"
        self.HeightText.isHidden = false
        height = HeightSlider.value
        self.displaySliderVal()
    }
    
    @IBAction func weightSliderChanged(_ sender: Any) {
        self.WeightText.text = "\(WeightSlider.value)"
        self.WeightText.isHidden = false
        weight = WeightSlider.value
        self.displaySliderVal()
    }
    
    func displaySliderVal() {
        print("Height:")
        print(height)
        print("Weight:")
        print(weight)
        
        if height != 0 && weight != 0 {
            bmi = ((weight)/(height * height))*703
            self.BMIText.text = "BMI: \(bmi)"
            
            if bmi < 18 {
                self.BMIMessage.text = "You're Underweight"
                self.BMIMessage.textColor = UIColor.blue
            }
            else if bmi >= 18 && bmi < 25 {
                self.BMIMessage.text = "You're Normal"
                self.BMIMessage.textColor = UIColor.green
            }
            else if bmi >= 25 && bmi <= 30 {
                self.BMIMessage.text = "You're Pre-Obese"
                self.BMIMessage.textColor = UIColor.purple
            }
            else{
                self.BMIMessage.text = "You're Obese"
                self.BMIMessage.textColor = UIColor.red
            }
            
            self.BMIText.isHidden = false
            self.BMIMessage.isHidden = false
        }
    }
    
    

    
    
    
    
}

