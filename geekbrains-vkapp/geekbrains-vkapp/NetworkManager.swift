//
//  NetworkManager.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import Foundation

class NetworkManager {
    
    private let apiUrl = "https://api.vk.com/method/"
    
    private func generateUrl(method: String, parameter: String) -> URL {
        
        let session = UserSession.shared
        let url = apiUrl + method + "?" + parameter + "&access_token=" + session.token + "&v=5.126"
        
        if let apiUrlString = URL(string: url) {
            return apiUrlString
        }
        return URL(string: "undefined")!
    }
    
    func getNews() {
        let session = URLSession.shared
        
        let url = generateUrl(method: "newsfeed.get", parameter: "filters=post")
        
        if url != URL(string: "undefined") {
            let task = session.dataTask(with: url) { (data, response, error) in
                print(data)
            }
            task.resume()
        }
    }
    
    func getPhotos(friendId: Int?) {
        let session = URLSession.shared
        
        let userSession = UserSession.shared
        let url = generateUrl(method: "photos.getAll", parameter: "owner_id=" + String(friendId!) == nil ? String(userSession.userId) : String(friendId ?? 0))
        
        if url != URL(string: "undefined") {
            let task = session.dataTask(with: url) { (data, response, error) in
                print(data)
            }
            task.resume()
        }
    }
    
    func getFriends() {
        let session = URLSession.shared
        
        let url = generateUrl(method: "friends.get", parameter: "fields=nickname")
        
        if url != URL(string: "undefined") {
            let task = session.dataTask(with: url) { (data, response, error) in
                print(data)
            }
            task.resume()
        }
    }
    
    func getGroups() {
        let session = URLSession.shared
        
        let url = generateUrl(method: "groups.get", parameter: "fields=description")
        
        if url != URL(string: "undefined") {
            let task = session.dataTask(with: url) { (data, response, error) in
                print(data)
            }
            task.resume()
        }
    }
    
    func findGroup(value: String) {
        let session = URLSession.shared
        
        let url = generateUrl(method: "groups.search", parameter: "q=" + value)
        
        if url != URL(string: "undefined") {
            let task = session.dataTask(with: url) { (data, response, error) in
                print(data)
            }
            task.resume()
        }
    }
}
