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


    @IBOutlet weak var rangerVCButton: UIButton!
    
    var delegate: MainVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonCollect(_ sender: UIButton) {
        delegate?.buttonToPage(indexPath: sender.tag)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? TeamPageViewController {
            delegate = pageViewController
        }
    }
    
}



