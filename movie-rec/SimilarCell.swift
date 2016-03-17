//
//  SimilarCell.swift
//  movie-rec
//
//  Created by Eric Drew on 3/17/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class SimilarCell: UITableViewCell {
    @IBOutlet weak var indexLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(similar: Similar) {
        indexLbl.text = similar.index
        titleLbl.text = similar.title
    }

}
