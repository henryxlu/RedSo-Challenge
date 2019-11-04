//
//  RangerViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

class RangerViewController: UIViewController {
    
    enum cellType {
        case employee
        case banner
    }
    
    
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
            return employeeCell
        } else {
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: "bannerCell", for: indexPath) as! BannerTableViewCell
            
            return bannerCell
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
