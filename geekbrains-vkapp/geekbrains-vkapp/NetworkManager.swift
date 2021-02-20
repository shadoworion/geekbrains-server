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
        let url = apiUrl + method + "?" + parameter + "&access_token=" + session.token + "&v=5.130"
        
        if let apiUrlString = URL(string: url) {
            return apiUrlString
        }
        return URL(string: "nil")!
    }
    
    func getNews(complitionHandler: @escaping (PostsResponse) -> ()) {
        let session = URLSession.shared
        
        let url = generateUrl(method: "newsfeed.get", parameter: "filters=post&count=100")
        if url != URL(string: "nil") {
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let posts = try JSONDecoder().decode(VKPosts.self, from: data)
                    complitionHandler(posts.response)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func getFriends(complitionHandler: @escaping ([VKFriend]) -> ()) {
        let session = URLSession.shared
        
        let url = generateUrl(method: "friends.get", parameter: "fields=photo_50")

        if url != URL(string: "nil") {
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let friends = try JSONDecoder().decode(VKFriends.self, from: data)
                    complitionHandler(friends.response.items)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func getPhotos(friendId: Int, complitionHandler: @escaping ([VKPhoto]) -> ()) {
        let session = URLSession.shared
        
        let url = generateUrl(method: "photos.getAll", parameter: "owner_id=" + String(friendId))
        if url != URL(string: "nil") {
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let photos = try JSONDecoder().decode(VKPhotos.self, from: data)
                    complitionHandler(photos.response.items)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func getGroups(complitionHandler: @escaping ([VKGroup]) -> ()) {
        let session = URLSession.shared
        let userSession = UserSession.shared
        
        let url = generateUrl(method: "groups.get", parameter: "user_id=" + String(userSession.userId) + "&extended=1&count=100")
        if url != URL(string: "nil") {
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let groups = try JSONDecoder().decode(VKGroups.self, from: data)
                    complitionHandler(groups.response.items)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func getAllGroups(complitionHandler: @escaping ([VKGroup]) -> ()) {
        let session = URLSession.shared
        
        let url = generateUrl(method: "groups.getCatalog", parameter: "")
        if url != URL(string: "nil") {
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let groups = try JSONDecoder().decode(VKGroups.self, from: data)
                    complitionHandler(groups.response.items)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func findGroup(value: String?, complitionHandler: @escaping ([VKGroup]) -> ()) {
        let session = URLSession.shared
        
        let url = generateUrl(method: "groups.search", parameter: "q=" + String(value ?? "") + "&count=100")
        
        if url != URL(string: "nil") {
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let groups = try JSONDecoder().decode(VKGroups.self, from: data)
                    complitionHandler(groups.response.items)
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
