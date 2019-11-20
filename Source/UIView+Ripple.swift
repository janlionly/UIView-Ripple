//
//  UIView+Radar.swift
//  TestCocoaPods
//
//  Created by janlionly<jan_ron@qq.com> on 2019/11/20.
//  Copyright © 2019 Janlionly<jan_ron@qq.com>. All rights reserved.
//

import UIKit

extension UIView {
    open func addRippleAnimation(color: UIColor, duration: Double = 1.5, rippleCount: Int = 3, rippleDistance: CGFloat? = nil) {
        let rippleAnimationAvatarSize = self.frame.size
        let rippleAnimationLineWidth: CGFloat = 1.0
        let rippleAnimationDuration: Double = duration
        var rippleAnimationExpandSizeValue: CGFloat = 0
        
        if let distance = rippleDistance {
            rippleAnimationExpandSizeValue = distance
        } else {
            rippleAnimationExpandSizeValue = rippleAnimationAvatarSize.width / 3.0
        }
        
        let initPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        
        let finalPath = UIBezierPath(ovalIn: CGRect(x: -rippleAnimationExpandSizeValue, y: -rippleAnimationExpandSizeValue, width: rippleAnimationAvatarSize.width + rippleAnimationExpandSizeValue * 2, height: rippleAnimationAvatarSize.height + rippleAnimationExpandSizeValue * 2).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        clipsToBounds = false
        
        var layers: [CALayer] = []
        if let count = self.layer.sublayers?.count {
            for i in 0..<count {
                if let lyrs = self.layer.sublayers, let layer = lyrs[i] as? CAReplicatorLayer {
                    layers.append(layer)
                    layer.isHidden = true
                }
            }
        }
        
        let count = layers.count
        for i in 0..<count {
            layers[i].removeFromSuperlayer()
        }
        
        let replicator = CAReplicatorLayer()
        replicator.instanceCount = rippleCount
        replicator.instanceDelay = rippleAnimationDuration / Double(rippleCount)
        replicator.backgroundColor = UIColor.clear.cgColor
        replicator.name = "ReplicatorForRipple"
        self.layer.addSublayer(replicator)

        let shape = animationLayer(path: initPath, color: color)
        shape.frame = CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height)
        replicator.addSublayer(shape)

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = initPath.cgPath
        pathAnimation.toValue = finalPath.cgPath

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(value: 1)
        opacityAnimation.toValue = NSNumber(value: 0)

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [pathAnimation, opacityAnimation]
        groupAnimation.duration = rippleAnimationDuration
        groupAnimation.repeatCount = Float(Int.max)

        shape.add(groupAnimation, forKey: nil)
    }
    
    open func removeRippleAnimation() {
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                replicator.removeFromSuperlayer()
            }
        })
    }
    
    open var isRippleAnimating: Bool {
        var animating = false
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                animating = true
            }
        })
        return animating
    }
    
    private func animationLayer(path: UIBezierPath, color: UIColor) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = color.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = 1.0
        return shape
    }
}
