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
    private var _title: String!
    
    var index: String {
        return _index
    }
    
    var title: String {
        return _title
    }
    
    init(index: Int, title: String) {
        _index = "\(index)."
        _title = title
    }
    
}