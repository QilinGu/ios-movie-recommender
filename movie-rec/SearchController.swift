//
//  SearchController.swift
//  movie-rec
//
//  Created by Eric Drew on 3/18/16.
//  Copyright © 2016 Eric Drew. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var searchAr = [Movie]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        searchBar.delegate = self
        searchAr = MovieInfo.instance.movieList
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let search = searchAr[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier(SEARCH_CELL_ID) as? SearchCell {
            cell.configureCell(search)
            return cell
        } else {
            return SearchCell()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
