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
    var movieTitle: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        movieLbl.text = movieTitle
        let url = NSURL(string: "http://www.imdb.com/title/tt3460252/")!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    override func viewWillAppear(animated: Bool) {
        circleLoader.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIView.animateWithDuration(1.0, animations: {
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
