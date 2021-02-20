//
//  UserGroupCell.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class UserGroupCell: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupAvatar: UIImageView!
    
    func setData(title: String, avatar: URL?){
        groupLabel.text = title
        if avatar == nil {
            groupAvatar.image = UIImage(systemName: "person.2.square.stack.fill")
        } else {
            groupAvatar.load(url: avatar!)
        }
    }
}
