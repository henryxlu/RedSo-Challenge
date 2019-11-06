//
//  ViewController.swift
//  RedSoChallenge
//
//  Created by Henry on 2019/11/1.
//  Copyright © 2019 Henry. All rights reserved.
//

import UIKit

protocol ChangePageDelegate {
    func buttonChangePage(indexPath: Int)
}

class ViewController: UIViewController, ChangeUnderlineDelegate {
    
    func moveUnderline(currentPage: Int) {
        guard (0..<3).contains(currentPage) else {
            return
        }
        UIView.animate(withDuration: 0.2) {
            var underLineOrigin = self.underLine.frame.origin.x
            switch currentPage {
            case 0:
                underLineOrigin = self.rangerButton.frame.origin.x
            case 1:
                underLineOrigin = self.elasticButton.frame.origin.x
            case 2:
                underLineOrigin = self.dynamoButton.frame.origin.x
            default:
                break
            }
            self.underLine.frame.origin.x = underLineOrigin
        }
    }
    
    @IBOutlet weak var rangerButton: UIButton!
    @IBOutlet weak var elasticButton: UIButton!
    @IBOutlet weak var dynamoButton: UIButton!
    @IBOutlet weak var underLine: UIView!
    
    var delegate: ChangePageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.underLine.frame.size.width = self.rangerButton.frame.size.width
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.01775177382, blue: 0.1321369112, alpha: 1)
    }
    
    @IBAction func buttonCollect(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.underLine.frame.origin.x = sender.frame.origin.x
        }
        delegate?.buttonChangePage(indexPath: sender.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? TeamPageViewController {
            delegate = pageViewController
            pageViewController.underlineDelegate = self
        }
    }
}



