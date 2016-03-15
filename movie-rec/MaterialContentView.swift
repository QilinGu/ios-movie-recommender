//
//  MaterialContentView.swift
//  movie-rec
//
//  Created by Eric Drew on 3/15/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class MaterialContentView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 3.0
        self.clipsToBounds = true
        self.layer.shadowOffset = CGSizeMake(3.0, 3.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = UIColor(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
    }

}
