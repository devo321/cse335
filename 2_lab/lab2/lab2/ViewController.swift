//
//  ViewController.swift
//  lab2
//
//  Created by Deven Pile on 1/30/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightTB: UITextField!
    @IBOutlet weak var ComingFromMoon: UILabel!
    @IBOutlet weak var fromJupiterLbl: UILabel!
    var moonWeight:Float?
    var earthWeight:Int?
    var jupiterWeight:Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ComingFromMoon.isHidden = true
        fromJupiterLbl.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let weight = Int(weightTB.text!)
        //let des = segue.destination as! MoonViewController
        if(segue.identifier == "toTheMoon"){
            let des = segue.destination as! MoonViewController
            des.weightFromFirst = weight
            
        }
        
    }
    @IBAction func fromSecond(segue: UIStoryboardSegue)
    {
        if let sourceView = segue.source as? MoonViewController {
            moonWeight = sourceView.weightOnMoonRtn
            earthWeight = sourceView.weightOnEarthRtn
            jupiterWeight = sourceView.weightOnJupiterRtn
            print(moonWeight)
            
            ComingFromMoon.isHidden = false
            fromJupiterLbl.isHidden = true
        }
        if let sourceView = segue.source as? JupiterViewController {
            moonWeight = sourceView.moonWeightRtn
            earthWeight = sourceView.earthWeightRtn
            jupiterWeight = sourceView.jupiterWeightRtn
            
            ComingFromMoon.isHidden = true
            fromJupiterLbl.isHidden = false
        }
      
    }
    
    
    


}

