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

    override func viewDidLoad() {
        super.viewDidLoad()
        setRec()
    }
    
    func setRec() {
        if starControl.StarCount > 0 {
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

}
