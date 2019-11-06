//
//  TeamPageViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

protocol ChangeUnderlineDelegate {
    func moveUnderline(currentPage: Int)
}

class TeamPageViewController: UIPageViewController, ChangePageDelegate {
    
    var underlineDelegate: ChangeUnderlineDelegate?
    
    func buttonChangePage(indexPath: Int) {
            let pageVC = subVCArray[indexPath]

            self.setViewControllers([pageVC], direction: .forward, animated: false, completion: nil)

    }
    

    lazy var subVCArray: [UIViewController] = {
        return [self.VCInstance(name: "RangerViewController"),
                self.VCInstance(name: "ElasticViewController"),
                self.VCInstance(name: "DynamoViewController")]
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageView()

    }

    
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: name)
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

        self.underlineDelegate?.moveUnderline(currentPage: currentIndex - 1)

        if (currentIndex <= 0) {
            return nil
        }
        return subVCArray[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex: Int = subVCArray.firstIndex(of: viewController) ?? 0

        self.underlineDelegate?.moveUnderline(currentPage: currentIndex + 1)
        
        if (currentIndex >= subVCArray.count-1 ){
            return nil
        }
        return subVCArray[currentIndex + 1]
    }
    
    
}

