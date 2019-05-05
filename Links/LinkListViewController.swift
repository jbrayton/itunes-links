//
//  LinkListViewController.swift
//  itunes-links
//
//  Created by John Brayton on 5/5/19.
//  Copyright © 2019 John Brayton. All rights reserved.
//

import UIKit

class LinkListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = String.localizedStringWithFormat("Links")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    // MARK: UITableViewController
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Link.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let link = Link.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        cell.textLabel?.text = link.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let link = Link.list[indexPath.row]
        self.GHS_open(url: link.url)
    }

}

