//
//  SearchCell.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var movieLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(search: Search) {
        movieLbl.text = search.movieTitle
    }

}
