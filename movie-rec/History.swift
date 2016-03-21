//
//  History.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation
import UIKit

class History {
    private var _movie: Movie!
    private var _rating: CGFloat!
    
    var movieTitle: String {
        return _movie.title
    }
    
    var rating: CGFloat {
        return _rating
    }
    
    init(movie: Movie, rating: CGFloat) {
        _movie = movie
        _rating = rating
    }
    
}