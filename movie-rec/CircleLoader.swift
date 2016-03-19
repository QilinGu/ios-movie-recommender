//
//  CircleLoader.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

@IBDesignable
class CircleLoader: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        backgroundColor = UIColor.clearColor()
    }
    
    func circlePath(pct: CGFloat, start: CGFloat, end: CGFloat, color: CGColor) -> CAShapeLayer {
        let circlePathLayer = CAShapeLayer()
        let circleWidth: CGFloat = 5.0
        
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = circleWidth
        circlePathLayer.fillColor = UIColor.clearColor().CGColor
        layer.addSublayer(circlePathLayer)
        
        var circleFrame = CGRect(x: 0, y: 0, width: self.bounds.width * pct - circleWidth, height: self.bounds.height * pct - circleWidth)
        circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame)
        circlePathLayer.path = UIBezierPath(ovalInRect: circleFrame).CGPath
        
        circlePathLayer.strokeStart = start
        circlePathLayer.strokeEnd = end
        circlePathLayer.strokeColor = color
        circlePathLayer.frame = bounds
        
        return circlePathLayer
    }
    
    
    
    func startAnimating() {
        var pathAr = [CAShapeLayer]()
        let strokeColor = UIColor(colorLiteralRed: 0.0/255.0, green: 145.0/255.0, blue: 234.0/255.0, alpha: 1.0).CGColor
        pathAr.append(circlePath(1.0, start: 0.0, end: 0.6, color: strokeColor))
        pathAr.append(circlePath(0.75, start: 0.2, end: 0.8, color: strokeColor))
        pathAr.append(circlePath(0.5, start: 0.4, end: 1.0, color: strokeColor))
        pathAr.append(circlePath(0.25, start: 0.4, end: 1.0, color: strokeColor))
        
        pathAr[0].anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pathAr[1].anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pathAr[2].anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pathAr[3].anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.repeatCount = Float.infinity
        rotateAnimation.values = [0, M_PI, 2 * M_PI]
        
        rotateAnimation.duration = 2.0
        rotateAnimation.values = rotateAnimation.values!.reverse()
        pathAr[0].addAnimation(rotateAnimation, forKey: "transform.rotation.z")
        
        rotateAnimation.duration = 4.0
        rotateAnimation.values = rotateAnimation.values!.reverse()
        pathAr[1].addAnimation(rotateAnimation, forKey: "transform.rotation.z")
        
        rotateAnimation.duration = 3.0
        rotateAnimation.values = rotateAnimation.values!.reverse()
        pathAr[2].addAnimation(rotateAnimation, forKey: "transform.rotation.z")
        
        rotateAnimation.duration = 2.5
        rotateAnimation.values = rotateAnimation.values!.reverse()
        pathAr[3].addAnimation(rotateAnimation, forKey: "transform.rotation.z")

    }
    
    func stopAnimating() {
        self.layer.removeAllAnimations()
    }

}
