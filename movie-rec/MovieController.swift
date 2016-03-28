//
//  MovieController.swift
//  movie-rec
//
//  Created by Eric Drew on 3/15/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class MovieController: UIViewController,UIPopoverPresentationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var starControl: StarControl!
    @IBOutlet weak var recBtn: MaterialButtonView!
    @IBOutlet weak var posterView: MaterialContentView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterConstraint: NSLayoutConstraint!
    @IBOutlet weak var starView: MaterialContentView!
    @IBOutlet weak var posterImg: MaterialImageView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postBlur: UIImageView!
    @IBOutlet weak var segBtn: SegButtonView!
    @IBOutlet weak var likedLbl: UILabel!
    
    var similarAr = [Similar]()
    var movie: Movie?
    var history: History?
    var seg = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.hidden = true
        tableView.alpha = 0.0
        likedLbl.hidden = true
        likedLbl.alpha = 0.0
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.view.bounds
        postBlur.addSubview(blurView)
        
        setRec()
        genRec()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(MovieController.posterTapped(_:)))
        posterImg.userInteractionEnabled = true
        posterImg.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        selectMovie()
    }
    
    func selectMovie() {
        if seg {
            if let hist = history {
                movie = hist.movie
                let completionBlock: (img: UIImage) -> () = { img in
                    self.nextMovie(hist.movie, image: img, resetStar: false)
                    self.starControl.currentStarCount = hist.rating
                }
                MovieInfo.instance.retrieveData(hist.movie.tmdbId, completion: completionBlock)
                history = nil
            } else {
                if let mov = movie {
                    if MovieInfo.instance.historySet[History(movie: mov, rating: 0.0)] != nil {
                        let completionBlock: (img: UIImage) -> () = { img in self.nextMovie(mov, image: img, resetStar: false) }
                        MovieInfo.instance.retrieveData(mov.tmdbId, completion: completionBlock)
                        self.starControl.currentStarCount = MovieInfo.instance.historySet[History(movie: mov, rating: 0.0)]!
                    } else {
                        let completionBlock: (img: UIImage) -> () = { img in self.nextMovie(mov, image: img, resetStar: true) }
                        MovieInfo.instance.retrieveData(mov.tmdbId, completion: completionBlock)
                    }
                }
            }
        }
        if let mov = movie {
            similarAr = []
            self.tableView.reloadData()
            let completionBlock: (movieAr: Array<Similar>) -> () = { ar in
                self.similarAr = ar
                self.tableView.reloadData()
            }
            MovieInfo.instance.getSimilarAr(mov, completion: completionBlock)
        }
        seg = false
    }
    
    func posterTapped(sender: AnyObject) {
        performSegueWithIdentifier(DETAIL_SEGUE, sender: nil)
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

    @IBAction func nextPressed(sender: UIButton) {
        sender.userInteractionEnabled = false
        if starControl.currentStarCount == 0 {
            //skip
        } else {
            //send review
            if let movie = movie {
                MovieInfo.instance.addReview(History(movie: movie, rating: starControl.currentStarCount))
            }
        }
        genRec()
    }
    
    func genRec() {
        let completionBlock: (mov: Movie) -> () = { mov in
            let completionBlock: (img: UIImage) -> () = { img in
                //TODO DON'T RESET STAR IF IN HISTORY
                self.nextMovie(mov, image: img, resetStar: true)
            }
            MovieInfo.instance.retrieveData(mov.tmdbId, completion: completionBlock)
        }
        MovieInfo.instance.getRec(completionBlock)
    }
    
    @IBAction func segPressed(sender: SegButtonView) {
        if sender.LeftSelected {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.starView.hidden = false
                self.posterView.hidden = false
                self.recBtn.hidden = false
                self.tableView.alpha = 0.0
                self.likedLbl.alpha = 0.0
                self.starView.alpha = 1.0
                self.posterView.alpha = 1.0
                self.recBtn.alpha = 1.0
                self.postBlur.alpha = 1.0
                }, completion: { (Bool) -> Void in
                    self.tableView.hidden = true
                    self.likedLbl.hidden = true
            })
            
        } else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.tableView.hidden = false
                self.likedLbl.hidden = false
                self.tableView.alpha = 1.0
                self.likedLbl.alpha = 1.0
                self.starView.alpha = 0.0
                self.posterView.alpha = 0.0
                self.recBtn.alpha = 0.0
                self.postBlur.alpha = 0.0
                }, completion: { (Bool) -> Void in
                    self.starView.hidden = true
                    self.posterView.hidden = true
                    self.recBtn.hidden = true
            })
        }
    }
    
    @IBAction func filterPressed(sender: AnyObject) {
        performSegueWithIdentifier(FILTER_SEGUE, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if FILTER_SEGUE == segue.identifier {
            if let popoverViewController = segue.destinationViewController as? FilterController {
                popoverViewController.popoverPresentationController!.delegate = self
                let rct = popoverViewController.popoverPresentationController!.sourceRect
                popoverViewController.popoverPresentationController!.sourceRect = rct.offsetBy(dx: filterBtn.bounds.width / 2.0, dy: filterBtn.bounds.height)
                popoverViewController.popoverPresentationController!.permittedArrowDirections = .Up
                popoverViewController.popoverPresentationController?.backgroundColor = UIColor(colorLiteralRed: 0.0/255.0, green: 145.0/255.0, blue: 234.0/255.0, alpha: 1.0)
            }
        }
        if DETAIL_SEGUE == segue.identifier {
            if let destinationVC = segue.destinationViewController as? MovieDetailController {
                destinationVC.movie = movie
            }
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        //update filter
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func nextMovie(movie: Movie, image: UIImage, resetStar: Bool) {
        self.movie = movie
        let totalDuration = 0.75
        self.posterConstraint.constant = -self.view.frame.width
        if resetStar {
            starControl.animateReset(totalDuration)
            UIView.animateWithDuration(totalDuration, animations: {
                self.recBtn.alpha = 0.7
            })
        }
        UIView.animateWithDuration(totalDuration/2, animations: {
            self.movieTitle.alpha = 0.0
            self.postBlur.alpha = 0.0
            self.view.layoutIfNeeded()
            }, completion: { finished in
                self.posterConstraint.constant = self.view.frame.width
                self.view.layoutIfNeeded()
                self.posterConstraint.constant = 0
                self.updateMovie(movie, image: image)
                UIView.animateWithDuration(totalDuration/2) {
                    self.movieTitle.alpha = 1.0
                    if self.segBtn.LeftSelected {
                        self.postBlur.alpha = 1.0
                    }
                    self.view.layoutIfNeeded()
                }
            self.recBtn.userInteractionEnabled = true
            })
    }
    
    func updateMovie(movie: Movie, image: UIImage) {
        self.movieTitle.text = movie.formattedTitle
        self.posterImg.image = image
        self.postBlur.image = image
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarAr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let similar = similarAr[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier(SIMILAR_CELL_ID) as? SimilarCell {
            cell.configureCell(similar)
            return cell
        } else {
            return SimilarCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mov = similarAr[indexPath.row].movie
        self.movie = mov
        seg = true
        self.tableView.hidden = true
        segBtn.LeftSelected = true
        selectMovie()
    }
    
}
