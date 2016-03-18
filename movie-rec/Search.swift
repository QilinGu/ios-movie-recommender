//
//  Search.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation

class Search {
    private let _movieTitle: String!
    
    var movieTitle: String {
        return _movieTitle
    }
    
    init(movieTitle: String) {
        _movieTitle = movieTitle
    }
    
}