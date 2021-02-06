//
//  Groups.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

protocol Groups {
    
    var id: Int { get set }
    
    var title: String { get set }
    
    var avatar: UIImage? { get set }
}

class Group: Groups {
    var id: Int
    
    var title: String
    
    var avatar: UIImage?
    
    init(id: Int, title: String, avatar: UIImage?) {
        self.id = id
        self.title = title
        self.avatar = avatar
    }
    
    func updateAvatar(avatar: UIImage){
        self.avatar = avatar
    }
}

let group1 = Group(id: 1, title: "Group 1", avatar: nil)
let group2 = Group(id: 2, title: "Group 2", avatar: nil)
let group3 = Group(id: 3, title: "Group 3", avatar: nil)
let group4 = Group(id: 4, title: "Group 4", avatar: nil)

let group5 = Group(id: 5, title: "Group 5", avatar: nil)
let group6 = Group(id: 6, title: "Group 6", avatar: nil)
let group7 = Group(id: 7, title: "Group 7", avatar: nil)
let group8 = Group(id: 8, title: "Group 8", avatar: nil)

var groupData: [Group] = [group1,group2,group3,group4]

var allGroupData: [Group] = [group5,group6,group7,group8]
