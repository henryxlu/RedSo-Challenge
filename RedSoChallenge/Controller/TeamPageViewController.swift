//
//  TeamPageViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

class TeamPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    lazy var subVCArray: [UIViewController] = {
        return [self.VCInstance(name: "RangerViewController") //,
//                self.VCInstance(name: ""),
//                self.VCInstance(name: "")
        ]
    }()
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPageVC()
    }
    
    func setPageVC() {
        self.delegate = self
        self.dataSource = self
    }

    //MARK - UIPageViewControllerDataSource
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subVCArray.count
    }
    
    
    
    

}
