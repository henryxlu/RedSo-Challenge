//
//  BannerTableViewCell.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/4.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerImage: UIImageView!{
        didSet {
            self.bannerImage.contentMode = .scaleAspectFit
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = #colorLiteral(red: 0, green: 0.01775177382, blue: 0.1321369112, alpha: 1)
    }
}
