//
//  filterVC.swift
//  movie-rec
//
//  Created by Eric Drew on 3/17/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class FilterController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var categoryAr = [MovieCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 7.0
        tableView.clipsToBounds = true
        
        categoryAr.append(MovieCategory(tag: "Comedy", state: true))
        categoryAr.append(MovieCategory(tag: "Comedy", state: true))
        categoryAr.append(MovieCategory(tag: "Comedy", state: true))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryAr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cat = categoryAr[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as? CategoryCell {
            cell.configureCell(cat)
            return cell
        } else {
            return CategoryCell()
        }
    }

}
