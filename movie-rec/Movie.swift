//
//  Movie.swift
//  movie-rec
//
//  Created by Eric Drew on 3/21/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation

class Movie: NSObject, NSCoding {
    private var _movieId: String!
    private var _title: String!
    private var _genres = [String]()
    private var _imdbId: String!
    private var _tmdbId: String!
    
    private let movieIdKey = "movieIdKey"
    private let titleKey = "titleKey"
    private let genreKey = "genreKey"
    private let imdbIdKey = "imdbIdKey"
    private let tmdbIdKey = "tmdbIdKey"
    
    
    var title: String {
        return _title
    }
    
    var formattedTitle: String {
        return _title
    }
    
    var tmdbId: String {
        return _tmdbId
    }
    
    var imdbId: String {
        return _imdbId
    }
    
    override var hashValue: Int {
        return (31 &* _tmdbId.hashValue)
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Movie {
            if self._movieId != object._movieId {
                return false
            }
            if self._title != object._title {
                return false
            }
            if self._genres != object._genres {
                return false
            }
            if self._imdbId != object._imdbId {
                return false
            }
            if self._tmdbId != object._tmdbId {
                return false
            }
            return true
        } else {
            return false
        }
    }
    
    init(movieId: String, title: String, genres: String, imdbId: String, tmdbId: String) {
        _movieId = movieId
        _title = title
        _genres = genres.componentsSeparatedByString("|")
        _imdbId = imdbId
        _tmdbId = tmdbId
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._movieId = aDecoder.decodeObjectForKey(movieIdKey) as! String
        self._title = aDecoder.decodeObjectForKey(titleKey) as! String
        self._genres = aDecoder.decodeObjectForKey(genreKey) as! [String]
        self._imdbId = aDecoder.decodeObjectForKey(imdbIdKey) as! String
        self._tmdbId = aDecoder.decodeObjectForKey(tmdbIdKey) as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._movieId, forKey: movieIdKey)
        aCoder.encodeObject(self._title, forKey: titleKey)
        aCoder.encodeObject(self._genres, forKey: genreKey)
        aCoder.encodeObject(self._imdbId, forKey: imdbIdKey)
        aCoder.encodeObject(self.tmdbId, forKey: tmdbIdKey)
    }
    
}