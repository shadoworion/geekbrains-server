//
//  FriendCollectionCell.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class FriendCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImage: UIImageView!
    
    func setData(avatar: UIImage?){
        if avatar == nil {
            friendImage.image = UIImage(systemName: "person.crop.circle.fill")
        } else {
            friendImage.image = avatar
        }
    }
}
