//
//  HistoryController.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class HistoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var historyAr = [History]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        historyAr = MovieInfo.instance.historyList
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let history = historyAr[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier(HISTORY_CELL_ID) as? HistoryCell {
            cell.configureCell(history)
            return cell
        } else {
            return HistoryCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyAr.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = historyAr[indexPath.row]
        if let destination = tabBarController!.viewControllers![1] as? MovieController {
            destination.history = cell
            destination.seg = true
        }
        tabBarController!.selectedIndex = MOVIE_TAB_INDEX
    }

}
