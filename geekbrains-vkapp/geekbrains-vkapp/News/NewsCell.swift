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
    
    
    func setData(title: String, poster: UIImage?, likes: Int){
        newsTitleLabel.text = title
        if poster == nil {
            newsPosterImage.image = UIImage(systemName: "moon.stars")
        } else {
            newsPosterImage.image = poster
        }
        likeCountLabel.text = String(likes)

        likes > 0 ? buttonLikedState(state: true) : buttonLikedState(state: false)
    }
    
    
    @IBAction func likeNews(_ sender: Any) {
        if likeCountLabel.text != "0" {
            likeAction(likeState: false)
            buttonLikedState(state: false)
        } else {
            likeAction(likeState: true)
            buttonLikedState(state: true)
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
        let index = newsData.firstIndex(where: {$0.title == newsTitleLabel.text})
        likeState ? newsData[index!].likePost() : newsData[index!].dissLikePost()
        likeCountLabel.text = String(newsData[index!].likes)
    }
    
}
