//
//  MovieController.swift
//  movie-rec
//
//  Created by Eric Drew on 3/15/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class MovieController: UIViewController {
    @IBOutlet weak var starControl: StarControl!
    @IBOutlet weak var recBtn: MaterialButtonView!
    @IBOutlet weak var posterView: MaterialContentView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setRec()
    }
    
    func setRec() {
        if starControl.currentStarCount > 0 {
            recBtn.alpha = 1.0
            recBtn.setTitle("next recommendation", forState: .Normal)
        } else {
            recBtn.alpha = 0.7
            recBtn.setTitle("I haven't seen it", forState: .Normal)
        }
    }

    @IBAction func starChanged(sender: StarControl) {
        setRec()
    }

    @IBAction func nextPressed(sender: AnyObject) {
        if starControl.currentStarCount == 0 {
            //skip
        } else {
            //send review
        }
        nextMovie()
    }
    
    func nextMovie() {
        let totalDuration = 0.75
        self.posterConstraint.constant = -self.view.frame.width
        starControl.animateReset(totalDuration)
        UIView.animateWithDuration(totalDuration/2, animations: {
            self.movieTitle.alpha = 0.0
            self.view.layoutIfNeeded()
            }, completion: { b in
                self.posterConstraint.constant = self.view.frame.width
                self.view.layoutIfNeeded()
                self.posterConstraint.constant = 0
                //TODO update title and image
                UIView.animateWithDuration(totalDuration/2) {
                    self.movieTitle.alpha = 1.0
                    self.view.layoutIfNeeded()
                }
            })
    }
}
