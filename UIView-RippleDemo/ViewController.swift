//
//  ViewController.swift
//  UIView-RippleDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/11/20.
//  Copyright © 2019 janlionly. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var normalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalView.addRippleAnimation(color: .systemPink, duration: 1.5, rippleCount: 3, rippleDistance: nil, startReset: false, handler: { animation in
            animation.delegate = self
        })
    }

    @IBAction func normalViewTapped(_ sender: Any) {
        normalView.addRippleAnimation(color: .systemPink, startReset: false, handler: { animation in
            animation.delegate = self
        })
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation stop")
        normalView.removeRippleAnimation()
    }
}

