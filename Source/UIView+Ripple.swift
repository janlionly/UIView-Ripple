//
//  UIView+Radar.swift
//  TestCocoaPods
//
//  Created by janlionly<jan_ron@qq.com> on 2019/11/20.
//  Copyright © 2019 Janlionly<jan_ron@qq.com>. All rights reserved.
//

import UIKit

extension UIView {
    open func addRippleAnimation(color: UIColor, duration: Double = 1.5, repeatCount: Int = 1, rippleCount: Int = 3, rippleDistance: CGFloat? = nil, expandMaxRatio ratio: CGFloat = 1, startReset: Bool = true) {
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
        
        let finalPath = UIBezierPath(ovalIn: CGRect(x: -rippleAnimationExpandSizeValue * ratio, y: -rippleAnimationExpandSizeValue * ratio, width: rippleAnimationAvatarSize.width + rippleAnimationExpandSizeValue * 2 * ratio, height: rippleAnimationAvatarSize.height + rippleAnimationExpandSizeValue * 2 * ratio).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        clipsToBounds = false
        
        if startReset {
            removeRippleAnimation()
        }
        
        let replicator = CAReplicatorLayer()
        replicator.instanceCount = rippleCount
        replicator.instanceDelay = rippleAnimationDuration / Double(rippleCount)
        replicator.backgroundColor = UIColor.clear.cgColor
        replicator.name = "ReplicatorForRipple"
        self.layer.addSublayer(replicator)

        let shape = animationLayer(path: initPath, color: color)
        shape.name = "ShapeForRipple"
        shape.frame = CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height)
        replicator.addSublayer(shape)

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.isRemovedOnCompletion = true
        pathAnimation.fromValue = initPath.cgPath
        pathAnimation.toValue = finalPath.cgPath

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(value: 1)
        opacityAnimation.toValue = NSNumber(value: 0)

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [pathAnimation, opacityAnimation]
        groupAnimation.duration = rippleAnimationDuration
        groupAnimation.repeatCount = Float(repeatCount)
        groupAnimation.isRemovedOnCompletion = true
        shape.add(groupAnimation, forKey: "RippleGroupAnimation")
    }
    
    open func removeRippleAnimation() {
        var layers: [CALayer] = []
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                replicator.sublayers?.forEach({ (ly) in
                    if ly.name == "ShapeForRipple" {
                        ly.isHidden = true
                        layers.append(ly)
                    }
                })
                replicator.isHidden = true
                layers.append(replicator)
            }
        })
        
        for i in 0..<layers.count {
            layers[i].removeFromSuperlayer()
        }
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
