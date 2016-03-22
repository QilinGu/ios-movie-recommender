//
//  History.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation
import UIKit

class History: NSObject, NSCoding {
    private var _movie: Movie!
    private var _rating: CGFloat!
    
    private let movieKey = "movie"
    private let ratingKey = "rating"
    
    var movieTitle: String {
        return _movie.title
    }
    
    var rating: CGFloat {
        return _rating
    }
    
    var movie: Movie {
        return _movie
    }
    
    override var hashValue: Int {
        return (31 &* _movie.hashValue)
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? History {
            return self._movie == object._movie
        } else {
            return false
        }
    }
    
    init(movie: Movie, rating: CGFloat) {
        _movie = movie
        _rating = rating
    }
    
    override init() {
    
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._movie = aDecoder.decodeObjectForKey(movieKey) as! Movie
        self._rating = aDecoder.decodeObjectForKey(ratingKey) as! CGFloat
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._movie, forKey: movieKey)
        aCoder.encodeObject(self._rating, forKey: ratingKey)
    }
    
}