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
    private var _movieTitle: String!
    private var _rating: CGFloat!
    
    var movieTitle: String {
        return _movieTitle
    }
    
    var rating: CGFloat {
        return _rating
    }
    
    init(movieTitle: String, rating: CGFloat) {
        _movieTitle = movieTitle
        _rating = rating
    }
    
}