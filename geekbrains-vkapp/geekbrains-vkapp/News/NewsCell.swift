//
//  NewsCell.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsPosterImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    private var postId: Int = 0
    private var canLike: Bool = false
    
    func setData(post_id: Int, title: String, poster: URL?, likes: Int, isLiked: Bool){
        postId = post_id
        canLike = !isLiked
        newsTitleLabel.text = title
        if poster == nil {
            newsPosterImage.image = UIImage(systemName: "moon.stars")
        } else {
            newsPosterImage.load(url: poster!)
        }
        likeCountLabel.text = String(likes)

        isLiked ? buttonLikedState(state: true) : buttonLikedState(state: false)
    }
    
    
    @IBAction func likeNews(_ sender: Any) {
        if canLike == false {
            likeAction(likeState: false)
            buttonLikedState(state: false)
            canLike = true
        } else {
            likeAction(likeState: true)
            buttonLikedState(state: true)
            canLike = false
        }
    }
    
    
    func buttonLikedState(state: Bool){
        if state {
            likeButton.tintColor = .systemRed
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
        } else {
            likeButton.tintColor = .systemBlue
            likeButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        }
    }
    
    func likeAction(likeState: Bool){
        let index = newsData.firstIndex(where: {$0.id == postId})
        likeState ? newsData[index!].likePost() : newsData[index!].dissLikePost()
        likeCountLabel.text = String(newsData[index!].likes)
    }
    
}
