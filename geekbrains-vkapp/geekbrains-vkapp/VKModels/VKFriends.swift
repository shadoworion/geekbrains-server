//
//  Photos.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 20/02/2021.
//

import Foundation

struct VKFriend: Codable {
    let id: Int
    let first_name, last_name: String
    let photo_50: URL?
}

struct FriendsResponse: Codable {
    let count: Int
    let items: [VKFriend]
}

struct VKFriends: Codable {
    let response: FriendsResponse
}

struct VKPhoto: Codable {
    let sizes: [PhotoSizes]
}

struct PhotosResponse: Codable {
    let count: Int
    let items: [VKPhoto]
}

struct VKPhotos: Codable {
    let response: PhotosResponse
}
