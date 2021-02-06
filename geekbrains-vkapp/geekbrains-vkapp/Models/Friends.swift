//
//  Friends.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

protocol Friends {
    var id: Int { get set }
    
    var fullname: String { get set }
    
    var avatar: UIImage? { get set }
}

class Friend: Friends {
    var id: Int
    
    var fullname: String
    
    var avatar: UIImage?
    
    var images: [UIImage?]
    
    init(id: Int, fullname: String, avatar: UIImage?) {
        self.id = id
        self.fullname = fullname
        self.avatar = avatar
        self.images = [nil, nil, nil]
    }
    
    func updateAvatar(avatar: UIImage){
        self.avatar = avatar
    }
    
    func addImage(image: UIImage?){
        images.append(image)
    }
}

let friend1 = Friend(id: 1, fullname: "Vasya Pupkin", avatar: nil)
let friend2 = Friend(id: 2, fullname: "Petya Petrov", avatar: nil)
let friend3 = Friend(id: 3, fullname: "Anton Antonov", avatar: nil)
let friend4 = Friend(id: 4, fullname: "Ivan Ivanov", avatar: nil)
let friend5 = Friend(id: 5, fullname: "Lorem Ipsum", avatar: nil)

var friendsData: [Friend] = [friend1, friend2, friend3, friend4, friend5]
