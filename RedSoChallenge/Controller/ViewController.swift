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
//        let navBarSize = navigationController!.navigationBar.bounds.size
//        let origin = CGPoint(x:navBarSize.width/2,y:navBarSize.height/2)
//        pageControl = UIPageControl(frame: CGRect(x: origin.x,y: origin.y,width: 10,height: 10))
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.navigationItem.titleView = self.pageControl
    }
    
    
    
//    let session = URLSession.shared
//    var staffs = [Staff.Result]()
//
//
//    func getAPI(team: String, page: Int) {
//        guard let url = URL(string: "https://us-central1-redso-challenge.cloudfunctions.net/catalog?team=\(team)&page=\(page)") else {
//            return
//        }
//        session.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//            guard let data = data else { return }
//            let decoder = JSONDecoder()
//            do {
//                try DispatchQueue.main.sync {
//                    self.staffs = try decoder.decode([Staff.Result].self, from: data)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
}

