//
//  EmployeeTableViewCell.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/4.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!{
        didSet {
            self.positionLabel.lineBreakMode = .byWordWrapping
            self.positionLabel.sizeToFit()
        }
    }
    @IBOutlet weak var expertiseLabel: UILabel! {
        didSet{
            self.expertiseLabel.lineBreakMode = .byWordWrapping
            self.expertiseLabel.sizeToFit()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
