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
    
    private var friendPhotos: [URL?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendCollection.delegate = self
        friendCollection.dataSource = self
        
        let task = NetworkManager()
        task.getPhotos(friendId: friendId) { (photos) in
            if (photos.count > 0) {
                for photo in photos {
                    self.friendPhotos.append(photo.sizes[0].url)
                }
            } else {
                self.friendPhotos.append(nil)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (friendPhotos.count > 0){
            return friendPhotos.count
        } else {
            let friend = friendsData.first(where: {$0.id == friendId})
            return friend!.images.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = friendCollection.dequeueReusableCell(withReuseIdentifier: "FriendCollectionCell", for: indexPath) as! FriendCollectionCell
        
        let index = indexPath.row
        var avatar: URL? = nil
        if (friendPhotos.count > 0) {
            avatar = friendPhotos[index]
        } else {
            let friend = friendsData.first(where: {$0.id == friendId})
            avatar = friend!.images[index]
        }
        
        cell.setData(avatar: avatar)
        
        return cell
    }

}
