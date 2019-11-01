//
//  TeamPageViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

class TeamPageViewController: UIPageViewController {
    
    lazy var subVCArray: [UIViewController] = {
        return [self.VCInstance(name: "RangerViewController"),
                self.VCInstance(name: "ElasticViewController"),
                //                self.VCInstance(name: "")
        ]
    }()
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPageView()
    }
    
    func setPageView() {
        self.delegate = self
        self.dataSource = self
        setViewControllers([subVCArray[0]], direction: .forward, animated: true, completion: nil)
    }
    
    
}

extension TeamPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    

    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subVCArray.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentIndex: Int = subVCArray.firstIndex(of: viewController) ?? 0
        if (currentIndex <= 0) {
            return nil
        }
        return subVCArray[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex: Int = subVCArray.firstIndex(of: viewController) ?? 0
        if (currentIndex >= subVCArray.count-1 ){
            return nil
        }
        return subVCArray[currentIndex + 1]
    }
    
    
}

