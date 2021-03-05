//
//  DetailViewController.swift
//  lab4
//
//  Created by Deven Pile on 2/22/21.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    var selectedCity:String?
    var selectedDesc:String?
    var selectedImg:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityName.text = selectedCity
        self.cityDesc.text = selectedDesc
        self.cityImg.image = selectedImg
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityImg: UIImageView!
    @IBOutlet weak var cityDesc: UILabel!
    
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
