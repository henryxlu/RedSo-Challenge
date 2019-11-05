//
//  ViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPageControl()
    }
    
    func setPageControl() {
//        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
//        self.pageControl.tintColor = UIColor.blue
        self.pageControl.backgroundColor = UIColor.green
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
//        self.navigationItem.titleView = self.pageControl
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? TeamPageViewController {
            pageViewController.pageViewControllerDelegate = self
        }
    }
    
}

extension ViewController: PageViewControllerDelegate {
    func pageViewController(_ pageViewController: TeamPageViewController, didUpdateNumberOfPage numberOfPage: Int) {
        self.pageControl.numberOfPages = numberOfPage
    }
    
    func pageViewController(_ pageViewController: TeamPageViewController, didUpdatePageIndex pageIndex: Int) {
        self.pageControl.currentPage = pageIndex
    }
    
    
}

