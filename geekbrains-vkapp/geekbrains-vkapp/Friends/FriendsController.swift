//
//  FriendsController.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class FriendsController: UITableViewController, UISearchBarDelegate {

    var friendsDict = [String: [String]]()
    var friendsSections = [String]()
    
    @IBOutlet var friendsTable: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    
    
    func setTableData() {
        friendsDict.removeAll()
        friendsSections.removeAll()
        
        for friend in friendsData {
            let friendKey = String(friend.fullname.prefix(1))
                if var friendValues = friendsDict[friendKey] {
                    friendValues.append(friend.fullname)
                    friendsDict[friendKey] = friendValues
                } else {
                    friendsDict[friendKey] = [friend.fullname]
                }
        }
        
        friendsSections = [String](friendsDict.keys)
        friendsSections = friendsSections.sorted(by: { $0 < $1 })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableData()
        
        friendsTable.delegate = self
        friendsTable.dataSource = self
        searchField.delegate = self
        
        let task = NetworkManager()
        task.getFriends { (friends) in
            if (friends.count > 0) {
                for friend in friends {
                    friendsData.append(Friend(id: friend.id, fullname: friend.first_name + " " + friend.last_name, avatar: friend.photo_50))
                }
            } else {
                friendsData.append(Friend(id: 1, fullname: "You have no friends", avatar: nil))
            }
            
            DispatchQueue.main.async {
                self.setTableData()
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if((searchField.text) != ""){
            let filteredData = friendsData.filter({$0.fullname.lowercased().contains((searchField.text?.lowercased())!)})

            friendsDict.removeAll()
            friendsSections.removeAll()
            
            for friend in filteredData {
                let friendKey = String(friend.fullname.prefix(1))
                    if var friendValues = friendsDict[friendKey] {
                        friendValues.append(friend.fullname)
                        friendsDict[friendKey] = friendValues
                    } else {
                        friendsDict[friendKey] = [friend.fullname]
                    }
            }
            
            friendsSections = [String](friendsDict.keys)
            friendsSections = friendsSections.sorted(by: { $0 < $1 })
        } else {
            setTableData()
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendKey = friendsSections[section]
        if let friendValues = friendsDict[friendKey] {
            return friendValues.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsTable.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        
        let friendKey = friendsSections[indexPath.section]
        if let friendValues = friendsDict[friendKey] {
            let getFriend = friendsData.first(where: {$0.fullname == friendValues[indexPath.row]})
            cell.setData(fullname: friendValues[indexPath.row], avatar: getFriend!.avatar)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSections[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSections
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let friendCollection = storyBoard.instantiateViewController(withIdentifier: "FriendCollection") as! FriendCollection
        friendCollection.title = tableView.cellForRow(at: indexPath)?.textLabel?.text
        let friend = friendsData.first(where: {$0.fullname == tableView.cellForRow(at: indexPath)?.textLabel?.text})
        friendCollection.friendId = friend!.id
        
        self.show(friendCollection, sender: self)
    }
}
