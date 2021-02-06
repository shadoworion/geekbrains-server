//
//  News.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

protocol News {
    var id: Int { get set }
    
    var title: String { get set }
    
    var poster: UIImage? { get set }
    
    var likes: Int { get set }
}

class Post: News {
    var id: Int
    
    var title: String
    
    var poster: UIImage?
    
    var likes: Int
    
    init(id: Int, title: String, poster: UIImage?) {
        self.id = id
        self.title = title
        self.poster = poster
        self.likes = 0
    }
    
    func updatePoster(poster: UIImage){
        self.poster = poster
    }
    
    func likePost(){
        self.likes += 1
    }
    
    func dissLikePost(){
        self.likes -= 1
    }
}

let post1 = Post(id: 1, title: "Post One", poster: nil)
let post2 = Post(id: 2, title: "Post Two", poster: nil)
let post3 = Post(id: 3, title: "Post Three", poster: nil)
let post4 = Post(id: 4, title: "Post Four", poster: nil)
let post5 = Post(id: 5, title: "Post Five", poster: nil)

var newsData: [Post] = [post1, post2, post3, post4, post5]
