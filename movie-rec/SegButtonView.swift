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
    private var leftSelected = true
    var rightLbl: UILabel!
    var leftLbl: UILabel!
    
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
        leftLbl = UILabel(frame: lRect)
        leftLbl.text = "recommended"
        leftLbl.textColor = BLUE_COLOR
        leftLbl.backgroundColor = DARK_COLOR
        leftLbl.font = UIFont(name: "Helvetica Neue", size: 14.0)
        leftLbl.textAlignment = .Center
        
        let rRect = CGRectMake(width / 2, 0, width / 2, self.bounds.height)
        rightLbl = UILabel(frame: rRect)
        rightLbl.text = "Similar"
        rightLbl.textColor = EXTRA_LIGHT_COLOR
        rightLbl.backgroundColor = DARK_COLOR
        rightLbl.font = UIFont(name: "Helvetica Neue", size: 14.0)
        rightLbl.textAlignment = .Center
        
        addSubview(leftLbl)
        addSubview(rightLbl)
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        if location.x > (self.bounds.width / 2) && leftSelected{
            leftSelected = false
            self.sendActionsForControlEvents(.ValueChanged)
            rightLbl.textColor = BLUE_COLOR
            leftLbl.textColor = EXTRA_LIGHT_COLOR
            return true
        } else if location.x <= (self.bounds.width / 2) && !leftSelected{
            leftSelected = true
            self.sendActionsForControlEvents(.ValueChanged)
            rightLbl.textColor = EXTRA_LIGHT_COLOR
            leftLbl.textColor = BLUE_COLOR
        }
        return true
    }

}
