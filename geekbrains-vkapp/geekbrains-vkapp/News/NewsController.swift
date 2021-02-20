//
//  NewsController.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class NewsController: UITableViewController {

    @IBOutlet var newsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.allowsSelection = false
        
        let task = NetworkManager()
        task.getNews { (response) in
            if (response.items.count > 0) {
                for post in response.items {
                    let source = -post.source_id
                    let title = response.groups.first(where: {$0.id == source})?.name
                    var poster: URL? = nil
                    if post.attachments?[0].link?.photo?.sizes[0].url != nil {
                        poster = post.attachments?[0].link?.photo?.sizes[0].url
                    }
                    if post.attachments?[0].photo?.sizes[0].url != nil {
                        poster = post.attachments?[0].photo?.sizes[0].url
                    }
                    if post.attachments?[0].video?.image[0].url != nil {
                        poster = post.attachments?[0].video?.image[0].url
                    }
                    
                    newsData.append(Post(id: post.post_id, title: title ?? "noname", poster: poster, likes: post.likes.count, isLiked: post.likes.can_like == 0))
                }
            } else {
                newsData.append(Post(id: 1, title: "You have no one post here", poster: nil, likes: 0, isLiked: false))
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        let index = indexPath.row
        let id = newsData[index].id
        let title = newsData[index].title
        let poster = newsData[index].poster
        let likes = newsData[index].likes
        let isLiked = newsData[index].isLiked
        
        cell.setData(post_id: id, title: title, poster: poster, likes: likes, isLiked: isLiked)
        
        return cell
    }
}
