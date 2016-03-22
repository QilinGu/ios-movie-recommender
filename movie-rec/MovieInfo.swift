//
//  MovieInfo.swift
//  movie-rec
//
//  Created by Eric Drew on 3/21/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import Foundation
import Alamofire

class MovieInfo {
    static let instance = MovieInfo()
    
    private var infoAr = [Movie]()
    private var _historySet = Dictionary<History, CGFloat>()
    
    var movieList: [Movie] {
        return infoAr
    }
    
    var historyList: [History] {
        return Array(_historySet.keys)
    }
    
    var historySet: Dictionary<History, CGFloat> {
        return _historySet
    }
    
    init() {
        movieTitles()
        loadHistory()
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
    
    func loadHistory() {
        let documentDirectoryURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let historyUrl = documentDirectoryURL.URLByAppendingPathComponent(HISTORY_FILE_NAME)
        
        _historySet = [:]
        if let resAr: [History] = NSKeyedUnarchiver.unarchiveObjectWithFile(historyUrl.path!) as? [History] {
            for item in resAr {
                _historySet[item] = item.rating
            }
        }
    }
    
    func saveHistory() {
        let documentDirectoryURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        let historyUrl = documentDirectoryURL.URLByAppendingPathComponent(HISTORY_FILE_NAME)
        let result = NSKeyedArchiver.archiveRootObject(historyList, toFile: historyUrl.path!)
        print("saving data worked: \(result)")
    }
    
    func addReview(movie: History) {
        _historySet[movie] = movie.rating
    }
    
    func retrieveData(tmdbId: String, completion: (image: UIImage) -> ()) {
        let urlString = API_URL.stringByReplacingOccurrencesOfString("{0}", withString: tmdbId)
        if let url = NSURL(string: urlString) {
            Alamofire.request(.GET, url).responseJSON { response in
                if let json = response.result.value as? Dictionary<String, AnyObject> {
                    if let postPath = json["poster_path"] as? String {
                        Alamofire.request(.GET, BASE_IMG_URL+postPath).response { request, response, data, error in
                            if let img = UIImage(data: data!) {
                                completion(image: img)
                            } else {
                                print("could not load image from data")
                            }
                        }
                    } else {
                        if let collection = json["belongs_to_collection"] as? Dictionary<String, AnyObject> {
                            if let postPath = collection["poster_path"] as? String {
                                Alamofire.request(.GET, BASE_IMG_URL+postPath).response { request, response, data, error in
                                    if let img = UIImage(data: data!) {
                                        completion(image: img)
                                    } else {
                                        print("could not load image from data")
                                    }
                                }
                            } else {
                                print("could not parse collection json")
                            }
                        } else {
                            print("could not parse json")
                        }
                    }
                } else {
                    print("could not parse response")
                }
            }
        } else {
            print(urlString)
        }
    }
    
}



