//
//  HealthTableViewCell.swift
//  Homework1
//
//  Created by Deven Pile on 4/16/21.
//

import UIKit

class HealthTableViewCell: UITableViewCell {

    @IBOutlet weak var bp1Lbl: UILabel!
    @IBOutlet weak var bp2Lbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var sugarLbl: UILabel!
    @IBOutlet weak var otherLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
