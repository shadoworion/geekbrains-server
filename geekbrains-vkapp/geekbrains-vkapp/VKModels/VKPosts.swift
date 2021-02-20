//
//  Posts.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 19/02/2021.
//

import Foundation

struct PhotoSizes: Codable {
    let height, width: Int
    let type: String?
    let url: URL?
}

struct Photo: Codable {
    let text: String?
    let sizes: [PhotoSizes]
}

struct Link: Codable {
    let photo: Photo?
}

struct Video: Codable {
    let image: [PhotoSizes]
}

struct Attachment: Codable {
    let photo: Photo?
    let link: Link?
    let video: Video?
}

struct Likes: Codable {
    let count, can_like: Int
}

struct VKPost: Codable {
    let post_id, source_id: Int
    let attachments: [Attachment]?
    let likes: Likes
}

struct PostsResponse: Codable {
    let items: [VKPost]
    let groups: [VKGroup]
}

struct VKPosts: Codable {
    let response: PostsResponse
}
