//
//  MovieController.swift
//  movie-rec
//
//  Created by Eric Drew on 3/15/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class MovieController: UIViewController,UIPopoverPresentationControllerDelegate{
    @IBOutlet weak var starControl: StarControl!
    @IBOutlet weak var recBtn: MaterialButtonView!
    @IBOutlet weak var posterView: MaterialContentView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterConstraint: NSLayoutConstraint!
    @IBOutlet weak var starView: MaterialContentView!
    @IBOutlet weak var posterImg: MaterialImageView!
    @IBOutlet weak var filterBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setRec()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:"posterTapped:")
        posterImg.userInteractionEnabled = true
        posterImg.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func posterTapped(sender: AnyObject) {
        performSegueWithIdentifier("detailVC", sender: nil)
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
    
    @IBAction func segPressed(sender: SegButtonView) {
        if sender.isLeftSelected {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.starView.hidden = false
                self.posterView.hidden = false
                self.recBtn.hidden = false
                self.starView.alpha = 1.0
                self.posterView.alpha = 1.0
                self.recBtn.alpha = 1.0
                }, completion: { (Bool) -> Void in
            })
            
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.starView.alpha = 0.0
                self.posterView.alpha = 0.0
                self.recBtn.alpha = 0.0
                }, completion: { (Bool) -> Void in
                    self.starView.hidden = true
                    self.posterView.hidden = true
                    self.recBtn.hidden = true
            })
        }
    }
    
    @IBAction func filterPressed(sender: AnyObject) {
        performSegueWithIdentifier("filterVC", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if "filterVC" == segue.identifier {
            if let popoverViewController = segue.destinationViewController as? filterVC {
                popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                popoverViewController.popoverPresentationController!.delegate = self
                let rct = popoverViewController.popoverPresentationController!.sourceRect
                popoverViewController.popoverPresentationController!.sourceRect = rct.offsetBy(dx: filterBtn.bounds.width / 2.0, dy: filterBtn.bounds.height)
                popoverViewController.popoverPresentationController!.permittedArrowDirections = .Up
            }
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        //update filter
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func nextMovie() {
        let totalDuration = 0.75
        self.posterConstraint.constant = -self.view.frame.width
        starControl.animateReset(totalDuration)
        UIView.animateWithDuration(totalDuration/2, animations: {
            self.movieTitle.alpha = 0.0
            self.view.layoutIfNeeded()
            }, completion: { finished in
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
