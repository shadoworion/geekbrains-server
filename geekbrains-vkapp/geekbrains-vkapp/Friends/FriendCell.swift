//
//  FriendCell.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    func setData(fullname: String, avatar: URL?){
        fullnameLabel.text = fullname
        if avatar == nil {
            avatarImage.image = UIImage(systemName: "person.crop.circle.fill")
        } else {
            avatarImage.load(url: avatar!)
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
