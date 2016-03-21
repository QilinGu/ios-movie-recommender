//
//  MovieInfo.swift
//  movie-rec
//
//  Created by Eric Drew on 3/21/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation

class MovieInfo {
    static let instance = MovieInfo()
    
    private var infoAr = [Movie]()
    
    var movieList: [Movie] {
        return infoAr
    }
    
    init() {
        movieTitles()
    }
    
    func movieTitles() {
        if let path = NSBundle.mainBundle().pathForResource("movieInfo", ofType: "csv") {
            do {
                var file = try NSString(contentsOfFile: path, encoding: NSASCIIStringEncoding)
                file = file.stringByReplacingOccurrencesOfString("\r", withString: "\n")
                file = file.stringByReplacingOccurrencesOfString("\n\n", withString: "\n")
                let rowAr = file.componentsSeparatedByString("\n")
                for row in rowAr {
                    var doubleQuote = row.componentsSeparatedByString("\"")
                    if doubleQuote.count > 1 {
                        let title = doubleQuote[1..<doubleQuote.count-1]
                        var col = (doubleQuote[0] + doubleQuote[doubleQuote.count-1]).componentsSeparatedByString(",")
                        col[1] = title.joinWithSeparator("")
                        infoAr.append(Movie(movieId: col[0], title: col[1], genres: col[2], imdbId: col[3], tmdbId: col[4]))
                        
                    } else {
                        let col = row.componentsSeparatedByString(",")
                        infoAr.append(Movie(movieId: col[0], title: col[1], genres: col[2], imdbId: col[3], tmdbId: col[4]))
                    }
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
        } else {
            print("no path")
        }
        infoAr.removeAtIndex(0)
    }
    
    func retrieveData() {
        //TODO
    }
    
}