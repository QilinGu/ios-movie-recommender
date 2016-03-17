//
//  CategoryCell.swift
//  movie-rec
//
//  Created by Eric Drew on 3/17/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categorySwitch.transform = CGAffineTransformMakeScale(0.65, 0.65)
    }
    
    func configureCell(movieCategory: MovieCategory) {
        categoryLabel.text = movieCategory.tag
        categorySwitch.setOn(movieCategory.onState, animated: false)
    }

}
