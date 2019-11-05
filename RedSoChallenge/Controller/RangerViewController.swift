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
            let range = (oldValue.count..<self.staffs.count)
            let insertedIndexList: [IndexPath] =
                range
                .map { IndexPath(row: $0, section: 0)}
//            dprint(range, insertedIndexList.count)
            tableview.insertRows(at: insertedIndexList, with: .automatic)
//            tableview.reloadData()
        }
    }
    var page:Int? = 0
    
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
            return tableViewHeightSize / 4.5
        } else {
            return tableViewHeightSize / 4
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let page = page else {return}
        
        let lastElement = staffs.count - 1
        if indexPath.row == lastElement - 2 {
            self.page! += 1
            APIManager.getTeam(team: "rangers", page: page) { (data) in
                DispatchQueue.main.sync {
//                    print("page:",self.page!, "data:", data.count)
                    if data.count == 0 {
//                           Void (self.page = nil)
                        return self.page = nil
                         }
                    self.staffs += data
                }
            }
        }
    }
    
}
