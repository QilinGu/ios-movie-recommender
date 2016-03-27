//
//  StarControl.swift
//  movie-rec
//
//  Created by Eric Drew on 3/15/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit
import Foundation

class StarControl: UIControl {
    private var starAr = [UIImageView]()
    private var starCount: CGFloat = 0.0
    private var beginPoint: CGPoint?
    private let numStars: Int = 5
    private var blankStar = false
    
    var currentStarCount: CGFloat {
        set {
            if newValue >= 0 && newValue <= 5 {
                starCount = newValue
                self.sendActionsForControlEvents(.ValueChanged)
                setNeedsDisplay()
            }
        }
        get {
            return starCount
        }
    }
    
    var blankEmpty: Bool {
        set {
            blankStar = newValue
        }
        get {
            return blankStar
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    func initAr() {
        starAr = []
        var emptyStar = UIImage(named: "star-empty-gold")
        if blankStar {
            emptyStar = nil
        }
        let padding = (self.bounds.width - (self.bounds.height * CGFloat(numStars))) / CGFloat(numStars)
        for i in 0...numStars - 1 {
            let rect = CGRectMake(CGFloat(i) * (self.bounds.height + padding) + (padding/2), 0.0, self.bounds.height, self.bounds.height)
            let star = UIImageView(frame: rect)
            if i < Int(starCount) {
                star.image = UIImage(named: "star-full-gold")
            } else if CGFloat(i) < starCount {
                star.image = UIImage(named: "star-half-gold")
            } else {
                star.image = emptyStar
                if starCount == 0 {
                    star.alpha = 0.3
                }
            }
            starAr.append(star)
        }
    }
    
    override func drawRect(rect: CGRect) {
        initAr()
        self.layer.sublayers = nil
        for star in starAr {
            addSubview(star)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = min(max(0.0, touch.locationInView(self).x), self.bounds.width)
            coordToStar(currentPoint)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = min(max(0.0, touch.locationInView(self).x), self.bounds.width)
            coordToStar(currentPoint)
        }
        self.sendActionsForControlEvents(.ValueChanged)
    }
    
    func coordToStar(point: CGFloat) {
        let padding = (self.bounds.width - (self.bounds.height * CGFloat(numStars))) / CGFloat(numStars)
        var str = point / (self.bounds.height + padding)
        str = round(str * 2) / 2
        starCount = str
        setNeedsDisplay()
        self.sendActionsForControlEvents(.ValueChanged)
    }
    
    func animateReset(duration: NSTimeInterval) {
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
        let empty = UIImage(named: "star-empty-gold")
        
        for i in (0..<starAr.count).reverse() {
            let dest = UIImageView(frame: starAr[i].frame)
            dest.image = empty
            UIView.animateWithDuration(duration, delay: 0.0, options: transitionOptions, animations: { () -> Void in
                self.starAr[i].alpha = 0.3
                }, completion: { (Bool) -> Void in
                    self.starCount = 0.0
                    self.setNeedsDisplay()
                    self.sendActionsForControlEvents(.ValueChanged)
            })
        }
    }
    
}
