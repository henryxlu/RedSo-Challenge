//
//  RangerViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit
import Kingfisher

class RangerViewController: UIViewController {
    
    
    var staffs : [Staff.Result] = []{
        didSet{
            tableview.reloadData()
        }
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        APIManager.getTeam(team: "rangers", page: 0) { (data) in
            DispatchQueue.main.sync {
                self.staffs = data
            }
        }
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
    }
    
}


extension RangerViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let staff = staffs[indexPath.row]
        
        
        if staff.type == "employee" {
            let employeeCell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeTableViewCell
            employeeCell.nameLabel.text = staff.name
            employeeCell.positionLabel.text = staff.position
            employeeCell.expertiseLabel.text = staff.expertise?.joined(separator: ", ")
            let url = URL(string: staff.avatar!)!
            KingfisherManager.shared.retrieveImage(with: url) { (result) in
                switch result {
                case .success(let s):
                    employeeCell.employeeImage.image = s.image
                case .failure(let f):
                    print(f.errorDescription!)
                    employeeCell.employeeImage.image = nil
                }
            }
            return employeeCell
            
        } else {
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: "bannerCell", for: indexPath) as! BannerTableViewCell
            let url = URL(string: staff.url!)!
            KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let s):
                    bannerCell.bannerImage.image = s.image
                case .failure(let f):
                    print(f.errorDescription!)
                    bannerCell.bannerImage.image = nil
                }
            }
            return bannerCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let staff = staffs[indexPath.row]
        let tableViewHeightSize = tableView.frame.size.height
        
        if staff.type == "employee" {
            let height = tableViewHeightSize / 4
            return height
        } else {
            let height = tableViewHeightSize / 4
            return height
        }
    }
}
