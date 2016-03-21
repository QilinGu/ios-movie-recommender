//
//  Movie.swift
//  movie-rec
//
//  Created by Eric Drew on 3/21/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation

class Movie {
    private var _movieId: String
    private var _title: String
    private var _genres: [String]
    private var _imdbId: String
    private var _tmdbId: String
    
    var title: String {
        return _title
    }
    
    var imdbId: String {
        return _imdbId
    }
    
    init(movieId: String, title: String, genres: String, imdbId: String, tmdbId: String) {
        _movieId = movieId
        _title = title
        _genres = genres.componentsSeparatedByString("|")
        _imdbId = imdbId
        _tmdbId = tmdbId
    }
    
}