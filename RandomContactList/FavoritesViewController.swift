//
//  FavoritesViewController.swift
//  RandomContactList
//
//  Created by Jorgen Shiller on 05.01.2023.
//

import UIKit

class FavoritesViewController: UITableViewController {

    var favoriteContacts: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.navigationItem.title = "Favorite Contact's"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteContacts.count
    }
}
