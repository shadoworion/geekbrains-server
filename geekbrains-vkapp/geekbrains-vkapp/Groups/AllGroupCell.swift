//
//  AllGroupCell.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class AllGroupCell: UITableViewCell {

    @IBOutlet weak var allGroupLabel: UILabel!
    @IBOutlet weak var allGroupAvatar: UIImageView!
    
    func setData(title: String, avatar: UIImage?){
        allGroupLabel.text = title
        if avatar == nil {
            allGroupAvatar.image = UIImage(systemName: "person.2.square.stack.fill")
        } else {
            allGroupAvatar.image = avatar
        }
    }

}
