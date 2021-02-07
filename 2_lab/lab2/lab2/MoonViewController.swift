//
//  MoonViewController.swift
//  lab2
//
//  Created by Deven Pile on 1/30/21.
//

import UIKit

class MoonViewController: UIViewController {
    @IBOutlet weak var fromJupiterLbl: UILabel!
    @IBOutlet weak var weightOnEarthTB: UILabel!
    @IBOutlet weak var weightOnMoonLbl: UILabel!
    @IBOutlet weak var toJupiterBtn: UIButton!
    @IBOutlet weak var backToEarthMoon: UIButton!
    var weightFromFirst:Int?
    var weightOnMoonRtn:Float?
    var weightOnEarthRtn:Int?
    var weightOnJupiterRtn:Float?

    override func viewDidLoad() {
        super.viewDidLoad()
        fromJupiterLbl.isHidden = true
        let weightOnEarth = weightFromFirst!
        print(weightFromFirst)
        // Do any additional setup after loading the view.
        let weightOnMoon = calcMoonWeight(earthWeight: weightOnEarth)
        self.weightOnEarthTB.text = "Your Weight on Earth is: \(weightOnEarth)"
        self.weightOnMoonLbl.text = "Your Weight on the Moon is: \(weightOnMoon)"
        weightOnEarthRtn = weightOnEarth
        weightOnMoonRtn = weightOnMoon
    }
    
    func calcMoonWeight(earthWeight:Int) -> Float {
        return Float(earthWeight) * (1/6)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! JupiterViewController
        if (segue.identifier == "toJupiter"){
            des.earthWeightFromMoon = weightOnEarthRtn
            des.moonWeightFromMoon = weightOnMoonRtn
        }
    }
 
    
    @IBAction func fromJupiter(segue: UIStoryboardSegue){
        if let sourceView = segue.source as? JupiterViewController {
            weightOnEarthRtn = sourceView.earthWeightRtn
            weightOnMoonRtn = sourceView.moonWeightRtn
            weightOnJupiterRtn = sourceView.jupiterWeightRtn
            fromJupiterLbl.isHidden = false
        }
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
