//
//  MovieCategory.swift
//  movie-rec
//
//  Created by Eric Drew on 3/17/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation

class MovieCategory {
    private var _onState: Bool!
    private var _tag: String!
    
    var tag: String {
        return _tag
    }
    
    var onState: Bool {
        return _onState
    }
    
    init(tag: String, state: Bool) {
        _onState = state
        _tag = tag
    }
    
}