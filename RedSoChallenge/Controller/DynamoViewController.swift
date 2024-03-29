//
//  DynamoViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit
import Kingfisher

class DynamoViewController: UIViewController {
    
    var staffs : [Staff.Result] = []{
        didSet{
            #if DEBUG
            print("old:", oldValue.count, "new:", self.staffs.count)
            #endif
            if staffs.count == 0 {
                return tableview.reloadData()
            }
            let range = (oldValue.count..<self.staffs.count)
            /*取得新資料區間*/
            let insertedIndexList: [IndexPath] =
                range.map { IndexPath(row: $0, section: 0)}
            #if DEBUG
            dprint(range, insertedIndexList.count)
            #endif
            tableview.insertRows(at: insertedIndexList, with: .automatic)
        }
    }
    var page:Int? = 0
    var refreshControl : UIRefreshControl!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.getTeam(team: "dynamo", page: 0) { (data) in
            DispatchQueue.main.async {
                self.staffs = data
            }
        }
        setTableView()
        setRefreshControl()
    }
    
    private func setTableView() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.backgroundColor = #colorLiteral(red: 0, green: 0.01775177382, blue: 0.1321369112, alpha: 1)
    }
    
    private func setRefreshControl() {
        refreshControl = UIRefreshControl()
        tableview.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadData), for: .allEvents)
    }
    
    @objc private func loadData(){
        DispatchQueue.main.async {
            self.staffs = []
            self.page = 0
            APIManager.getTeam(team: "dynamo", page: self.page!) { (data) in
                DispatchQueue.main.async {
                    self.staffs = data
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
}

extension DynamoViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            employeeCell.selectionStyle = .none
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
            bannerCell.selectionStyle = .none
            return bannerCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let staff = staffs[indexPath.row]
        let tableViewHeightSize = tableView.frame.size.height
        
        if staff.type == "employee" {
            return tableViewHeightSize / 4
        } else {
            return tableViewHeightSize / 3.5
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let page = page else {return dprint("no page")}
        
        let lastElement = staffs.count - 1
        if indexPath.row == lastElement - 2 /*提前加載*/ {
            self.page! += 1
            APIManager.getTeam(team: "dynamo", page: page) { (data) in
                DispatchQueue.main.async {
                    #if DEBUG
                    print("page:",self.page!, "data:", data.count)
                    #endif
                    if data.count == 0 {
                        return self.page = nil
                    }
                    self.staffs += data
                }
            }
        }
    }
}
