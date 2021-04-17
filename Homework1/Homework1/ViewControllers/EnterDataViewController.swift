//
//  EnterDataViewController.swift
//  Homework1
//
//  Created by Deven Pile on 4/16/21.
//

import UIKit

class EnterDataViewController: UIViewController {

    @IBOutlet weak var bpSystolicTf: UITextField!
    @IBOutlet weak var bpDiastolicTf: UITextField!
    @IBOutlet weak var weightTf: UITextField!
    @IBOutlet weak var sugarLevelTf: UITextField!
    @IBOutlet weak var otherSymptomsTf: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        if bpSystolicTf.text?.isEmpty == true || bpDiastolicTf.text?.isEmpty == true || weightTf.text?.isEmpty == true || sugarLevelTf.text?.isEmpty == true {
            let alert = UIAlertController(title: "Warning", message: "Blood Preesure, Weight, and Sugar Level are required fields, please enter data for each field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            let newData = HealthInfo.init(bps: Int(bpSystolicTf.text!)!, bpd: Int(bpDiastolicTf.text!)!, weight: Int(weightTf.text!)!, sugarLevel: Int(sugarLevelTf.text!)!, other: otherSymptomsTf.text ?? "")
            GlobalData.SharedInstance.healthArray.append(newData)
            
            if(GlobalData.SharedInstance.healthArray.count > 7){
                GlobalData.SharedInstance.healthArray.remove(at: 0)
            }
            
            bpSystolicTf.text = ""
            bpDiastolicTf.text = ""
            weightTf.text = ""
            sugarLevelTf.text = ""
            otherSymptomsTf.text = ""
            
            let alert = UIAlertController(title: "", message: "Health Data Added", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)

            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when){
              alert.dismiss(animated: true, completion: nil)
            }
            
            /*
            for data in GlobalData.SharedInstance.healthArray{
                print("BP: \(data.systolic) \(data.diastolic)")
                print("Weight: \(data.weight)")
                print("Sugar Level: \(data.sugarLevel)")
                print("Other: \(String(describing: data.otherSymptoms!))")
             }*/
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
