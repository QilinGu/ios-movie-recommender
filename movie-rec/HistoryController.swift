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
        
        historyAr.append(History(movieTitle: "title 1 title 1 title 1 title 1 title 1", rating: 4.0))
        historyAr.append(History(movieTitle: "title 2", rating: 0.5))
        historyAr.append(History(movieTitle: "title 3", rating: 3.5))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let history = historyAr[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("historyCell") as? HistoryCell {
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

}
