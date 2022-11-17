//
//  ViewController.swift
//  RandomContactList
//
//  Created by Jorgen Shiller on 15.11.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var ContactFullName: UILabel!
    
    var contacts: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        ContactFullName.text = contacts.name.last
        contactImageView.layer.cornerRadius = contactImageView.bounds.height / 2
        contactImageView.layer.borderWidth  = 2
        contactImageView.layer.borderColor = UIColor.black.cgColor
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

