//
//  Similar.swift
//  movie-rec
//
//  Created by Eric Drew on 3/17/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation

class Similar {
    private var _index: String!
    private var _movie: Movie!
    
    var index: String {
        return _index
    }
    
    var title: String {
        return _movie.title
    }
    
    init(index: Int, movie: Movie) {
        _index = "\(index)."
        _movie = movie
    }
    
}