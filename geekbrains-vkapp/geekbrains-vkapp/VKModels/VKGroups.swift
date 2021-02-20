//
//  VKGroups.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 20/02/2021.
//

import Foundation

struct VKGroup: Codable {
    let id: Int
    let name: String
    let photo_50: URL?
}

struct GroupsResponse: Codable {
    let count: Int
    let items: [VKGroup]
}

struct VKGroups: Codable {
    let response: GroupsResponse
}
