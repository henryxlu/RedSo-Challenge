//
//  ViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

protocol MainVCDelegate {
    func buttonToPage(indexPath: Int)
}


class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var underLine: UIView!
    
    var delegate: MainVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.underLine.frame.size.width = self.button.frame.size.width
    }
    
    
    
    @IBAction func buttonCollect(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.underLine.frame.origin.x = sender.frame.origin.x
        }
        delegate?.buttonToPage(indexPath: sender.tag)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? TeamPageViewController {
            delegate = pageViewController
        }
    }
    
    
}



