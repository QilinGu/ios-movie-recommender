//
//  MaterialButtonView.swift
//  movie-rec
//
//  Created by Eric Drew on 3/15/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class MaterialButtonView: UIButton {

    override func awakeFromNib() {
        self.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3).CGColor
        self.layer.cornerRadius = 3.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 12.0
        let dim: CGFloat = self.bounds.height - (padding * 2)
        let rect = CGRectMake(self.bounds.width - dim - padding, padding, dim, dim)
        let arrow = UIImageView(frame: rect)
        arrow.image = UIImage(named: "right-arrow-white")
        addSubview(arrow)
    }
}
