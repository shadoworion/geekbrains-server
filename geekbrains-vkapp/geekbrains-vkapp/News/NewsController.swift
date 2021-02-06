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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        let index = indexPath.row
        let title = newsData[index].title
        let poster = newsData[index].poster
        let likes = newsData[index].likes
        
        cell.setData(title: title, poster: poster, likes: likes)
        
        return cell
    }
}
