//
//  ClassTableViewCell.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/5/21.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

    //MARK Properties
    @IBOutlet weak var classNameLbl: UILabel!
    @IBOutlet weak var classMeetingTimeLbl: UILabel!
    @IBOutlet weak var classImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
