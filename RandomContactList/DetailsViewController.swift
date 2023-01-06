//
//  ViewController.swift
//  RandomContactList
//
//  Created by Jorgen Shiller on 15.11.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var contactPhone: UILabel!
    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var ContactFullName: UILabel!
    @IBOutlet var ContactID: UILabel!
    @IBOutlet var DetailsLabel: UILabel!
    var contacts: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        ContactFullName.text = """
\(contacts.name.title) \(contacts.name.first)
\(contacts.name.last)
"""
        DetailsLabel.text = """
 Country: \(contacts.location.country)
 Postcode: \(contacts.location.postcode)
 email: \(contacts.email)
 """
        contactPhone.text = contacts.phone
        ContactID.text = "ID: \(contacts.id.value)"
        contactImageView.layer.cornerRadius = contactImageView.bounds.height / 2
        contactImageView.layer.borderWidth  = 2
        contactImageView.layer.borderColor = UIColor.black.cgColor
        
        navigationItem.title = ContactFullName.text
        
        NetworkManager.shared.fetchData(from: contacts.picture.thumbnail) { [weak self] result in
            switch result {
            case .success(let image):
                self?.contactImageView.image = UIImage(data: image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

