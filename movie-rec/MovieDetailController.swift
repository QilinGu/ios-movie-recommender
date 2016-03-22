//
//  MovieDetailController.swift
//  movie-rec
//
//  Created by Eric Drew on 3/17/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var movieLbl: UILabel!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var circleLoader: CircleLoader!
    
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        movieLbl.text = movie.title
        
        let cnt: Int = max(7 - movie.imdbId.characters.count, 0)
        let leadingZeros =  String(count: cnt, repeatedValue: Character("0"))
        let urlString = IMDB_BASE_URL + leadingZeros + movie.imdbId + "/"
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    override func viewWillAppear(animated: Bool) {
        circleLoader.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIView.animateWithDuration(4.0, animations: {
                self.coverView.alpha = 0.0
                self.circleLoader.alpha = 0.0
            }, completion: { finished in
                self.circleLoader.stopAnimating()
                self.coverView.hidden = true
        })
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
