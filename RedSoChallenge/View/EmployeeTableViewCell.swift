//
//  EmployeeTableViewCell.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/4.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeImage: UIImageView!{
        didSet {
            self.employeeImage.contentMode = .scaleAspectFit
            self.employeeImage.layer.cornerRadius = self.employeeImage.frame.height / 2
        }
    }
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
        self.backgroundColor = #colorLiteral(red: 0, green: 0.01775177382, blue: 0.1321369112, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
