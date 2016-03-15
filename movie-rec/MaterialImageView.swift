//
//  MaterialImageView.swift
//  movie-rec
//
//  Created by Eric Drew on 3/15/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class MaterialImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 3.0
        self.clipsToBounds = true
    }

}
