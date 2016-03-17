//
//  SegButtonView.swift
//  movie-rec
//
//  Created by Eric Drew on 3/16/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

@IBDesignable
class SegButtonView: UIControl {
    let blueColor = UIColor(colorLiteralRed: 0.0/255.0, green: 145.0/255.0, blue: 234/255.0, alpha: 1.0)
    let darkColor = UIColor(colorLiteralRed: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    let lightColor = UIColor(colorLiteralRed: 99.0/255.0, green: 99.0/255.0, blue: 99.0/255.0, alpha: 1.0)
    private var leftSelected = true
    var rightBtn: UIButton!
    var leftBtn: UIButton!
    
    var isLeftSelected: Bool {
        return leftSelected
    }
    
    override func awakeFromNib() {
        self.layer.shadowOffset = CGSizeMake(0.0, 3.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.7
        self.layer.shadowColor = UIColor(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5).CGColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.bounds.width
        
        let lRect = CGRectMake(0, 0, width / 2, self.bounds.height)
        leftBtn = UIButton(frame: lRect)
        leftBtn.setTitle("recommended", forState: .Normal)
        leftBtn.setTitleColor(blueColor, forState: .Normal)
        leftBtn.backgroundColor = darkColor
        leftBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14.0)
        leftBtn.userInteractionEnabled = false
        
        let rRect = CGRectMake(width / 2, 0, width / 2, self.bounds.height)
        rightBtn = UIButton(frame: rRect)
        rightBtn.setTitle("Similar", forState: .Normal)
        rightBtn.setTitleColor(lightColor, forState: .Normal)
        rightBtn.backgroundColor = darkColor
        rightBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14.0)
        rightBtn.userInteractionEnabled = false
        
        addSubview(leftBtn)
        addSubview(rightBtn)
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        if location.x > (self.bounds.width / 2) && leftSelected{
            leftSelected = false
            self.sendActionsForControlEvents(.ValueChanged)
            rightBtn.setTitleColor(blueColor, forState: .Normal)
            leftBtn.setTitleColor(lightColor, forState: .Normal)
            return true
        } else if !leftSelected{
            leftSelected = true
            self.sendActionsForControlEvents(.ValueChanged)
            rightBtn.setTitleColor(lightColor, forState: .Normal)
            leftBtn.setTitleColor(blueColor, forState: .Normal)
        }
        return true
    }

}
