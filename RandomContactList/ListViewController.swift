//
//  TableViewController.swift
//  RandomContactList
//
//  Created by Jorgen Shiller on 15.11.2022.
//

import UIKit

class ListViewController: UITableViewController {
    
    private var randomContacts: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        getData()
        setupRefreshControl()
        
        navigationItem.title = "Random Contact's"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomContacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        content.imageProperties.cornerRadius = 25
        
        let person = randomContacts[indexPath.row]
        content.text = person.name.first
        content.secondaryText = person.name.last
        
        let imageUrl  = person.picture.thumbnail
        
        NetworkManager.shared.fetchData(from: imageUrl) { result in
            switch result {
            case .success(let image):
                content.image = UIImage(data: image)
                cell.contentConfiguration = content
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = randomContacts[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: currentUser)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            randomContacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.contacts = sender as? User
    }
    
    // MARK: - Private Methods
    
    @objc private func getData() {
        NetworkManager.shared.fetchPerson(from: URLLinks.randomUserLink.rawValue) { [weak self] result in
            switch result {
            case .success(let persons):
                self?.randomContacts = persons
                self?.tableView.reloadData()
                if self?.refreshControl != nil {
                    self?.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(getData), for: .valueChanged)
    }
}
