//
//  TeamPageViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    
    func pageViewController(_ pageViewController: TeamPageViewController, didUpdateNumberOfPage numberOfPage: Int)
    

    func pageViewController(_ pageViewController: TeamPageViewController, didUpdatePageIndex pageIndex: Int)
}

class TeamPageViewController: UIPageViewController {
    
    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
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
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentViewController: UIViewController = (self.viewControllers?.first)!
        
        let currentIndex: Int = self.subVCArray.firstIndex(of: currentViewController)!
        
        self.pageViewControllerDelegate?.pageViewController(self, didUpdatePageIndex: currentIndex)
        
    }
    
}

