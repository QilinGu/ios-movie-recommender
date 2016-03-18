//
//  SearchController.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var searchAr = [Search]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchAr.append(Search(movieTitle: "title 1"))
        searchAr.append(Search(movieTitle: "title 2"))
        searchAr.append(Search(movieTitle: "title 3"))
        searchAr.append(Search(movieTitle: "title 4"))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let search = searchAr[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("searchCell") as? SearchCell {
            cell.configureCell(search)
            return cell
        } else {
            return SearchCell()
        }
    }

}
