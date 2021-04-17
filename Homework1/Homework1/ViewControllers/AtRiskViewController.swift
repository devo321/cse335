//
//  AtRiskViewController.swift
//  Homework1
//
//  Created by Deven Pile on 4/16/21.
//

import UIKit

class AtRiskViewController: UIViewController {

    @IBOutlet weak var atRiskMsgLbl: UILabel!
    @IBOutlet weak var sugarLevelLbl: UILabel!
    @IBOutlet weak var bpLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sugarLevelLbl.text = ""
        bpLbl.text = ""
        // Do any additional setup after loading the view.
        checkHealth()
    }
    
    func checkHealth(){
        var weightok:Bool = true
        var sugarOk:Bool = true
        var bpOk:Bool = true
        if GlobalData.SharedInstance.healthArray.count > 1{
            if GlobalData.SharedInstance.healthArray.count >= 4 {
                print("here")
                var fourDayAverage:Int = 0
                var threeDayAverage:Int = 0
                var counter:Int = 0
                for index in GlobalData.SharedInstance.healthArray.count - 4...GlobalData.SharedInstance.healthArray.count - 1{
                    fourDayAverage += GlobalData.SharedInstance.healthArray[index].weight
                    if counter < 4 {
                        threeDayAverage += GlobalData.SharedInstance.healthArray[index].weight
                    }
                    counter += 1
                }
                print(fourDayAverage)
                print(threeDayAverage)
                fourDayAverage = fourDayAverage / 4
                print(fourDayAverage)
                threeDayAverage = threeDayAverage / 3
                print(threeDayAverage)
                if(fourDayAverage < threeDayAverage){
                    atRiskMsgLbl.text = "You are gaining weight!"
                    //atRiskMsgLbl.isHidden = false
                    weightok = false
                    print("Gaining Weight")
                }
            }
            else{
                atRiskMsgLbl.text = ""
            }
            if GlobalData.SharedInstance.healthArray.count > 1 {
                let count:Int = GlobalData.SharedInstance.healthArray.count
                let today:Float = Float(GlobalData.SharedInstance.healthArray[count - 1].sugarLevel)
                let yesterday:Float = Float(GlobalData.SharedInstance.healthArray[count - 2].sugarLevel)
                if today > yesterday + (0.1*yesterday) {
                    sugarLevelLbl.text = "Your sugar level is high!"
                    sugarOk = false
                }
            }
            if GlobalData.SharedInstance.healthArray.count > 1{
                let count:Int = GlobalData.SharedInstance.healthArray.count
                let todaySys:Float = Float(GlobalData.SharedInstance.healthArray[count - 1].systolic)
                let yesterdaySys:Float = Float(GlobalData.SharedInstance.healthArray[count - 2].systolic)
                let todayDia:Float = Float(GlobalData.SharedInstance.healthArray[count - 1].diastolic)
                let yesterdayDia:Float = Float(GlobalData.SharedInstance.healthArray[count - 2].diastolic)
                if todaySys > yesterdaySys + (0.1*yesterdaySys) || todayDia > yesterdayDia + (0.1*yesterdayDia){
                    bpLbl.text = "Your Blood Pressure is High!"
                    bpOk = false
                }
                
            }
            if(weightok && sugarOk && bpOk){
                atRiskMsgLbl.text = "You are in good health, keep up the good work :)"
            }
            
        }
        else{
            atRiskMsgLbl.text = "Please enter more health data";
            atRiskMsgLbl.isHidden = false
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
