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
    
    func setData(fullname: String, avatar: UIImage?){
        fullnameLabel.text = fullname
        if avatar == nil {
            avatarImage.image = UIImage(systemName: "person.crop.circle.fill")
        } else {
            avatarImage.image = avatar
        }
    }
}
