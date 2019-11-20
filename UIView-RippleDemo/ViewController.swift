//
//  ViewController.swift
//  UIView-RippleDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/11/20.
//  Copyright © 2019 janlionly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var normalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalView.addRippleAnimation(color: .systemPink, duration: 1.5, rippleCount: 3, rippleDistance: nil)
    }

    @IBAction func normalViewTapped(_ sender: Any) {
        if normalView.isRippleAnimating {
            normalView.removeRippleAnimation()
        } else {
            normalView.addRippleAnimation(color: .systemPink)
        }
    }
}

