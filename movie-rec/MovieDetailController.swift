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

    var movieTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        movieLbl.text = movieTitle
        let url = NSURL(string: "http://www.imdb.com/title/tt3460252/")!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)

    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        //TODO
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //TODO
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
