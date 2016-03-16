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
    
    var StarCount: CGFloat {
        return starCount
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
        let emptyStar = UIImage(named: "star-empty-gold")
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
                if StarCount == 0 {
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


}
