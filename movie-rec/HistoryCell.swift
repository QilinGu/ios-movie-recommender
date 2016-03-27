//
//  HistoryCell.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var starControl: StarControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starControl.blankEmpty = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(history: History) {
        titleLbl.text = history.movieTitle
        starControl.currentStarCount = history.rating
    }

}
