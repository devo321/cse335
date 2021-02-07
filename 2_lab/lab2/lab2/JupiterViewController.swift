//
//  JupiterViewController.swift
//  lab2
//
//  Created by Deven Pile on 1/30/21.
//

import UIKit

class JupiterViewController: UIViewController {
    @IBOutlet weak var earthWeightLbl: UILabel!
    @IBOutlet weak var moonWeightLbl: UILabel!
    @IBOutlet weak var jupiterWeightLbl: UILabel!
    var earthWeightFromMoon:Int?
    var moonWeightFromMoon:Float?
    
    var earthWeightRtn:Int?
    var moonWeightRtn:Float?
    var jupiterWeightRtn:Float?

    override func viewDidLoad() {
        super.viewDidLoad()
        earthWeightRtn = earthWeightFromMoon!
        moonWeightRtn = moonWeightFromMoon
        jupiterWeightRtn = calcJupiterWeight(earthWeight: earthWeightRtn!)
        
        self.earthWeightLbl.text = "Your Weight on Earth is: \(earthWeightRtn!)"
        self.moonWeightLbl.text = "Your Weight on the Moon is: \(moonWeightRtn!)"
        self.jupiterWeightLbl.text = "Your Weight on Jupiter is: \(jupiterWeightRtn!)"
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func calcJupiterWeight(earthWeight:Int) -> Float{
        return Float(earthWeight) * 2.4
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
