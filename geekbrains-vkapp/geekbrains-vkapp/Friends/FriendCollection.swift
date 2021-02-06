//
//  FriendCollection.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class FriendCollection: UICollectionViewController {
    
    @IBOutlet var friendCollection: UICollectionView!
    
    public var friendId: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendCollection.delegate = self
        friendCollection.dataSource = self
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let friend = friendsData.first(where: {$0.id == friendId})
        return friend!.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = friendCollection.dequeueReusableCell(withReuseIdentifier: "FriendCollectionCell", for: indexPath) as! FriendCollectionCell
        
        let index = indexPath.row
        let friend = friendsData.first(where: {$0.id == friendId})
        let avatar = friend!.images[index]
        
        cell.setData(avatar: avatar)
        
        return cell
    }

}
