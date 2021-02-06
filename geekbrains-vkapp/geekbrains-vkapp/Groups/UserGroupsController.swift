//
//  UserGroupsController.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class UserGroupsController: UITableViewController, UISearchBarDelegate {

    var localData = [Group]()
    
    func setTableData(data: [Group]){
        localData.removeAll()
        localData.append(contentsOf: data)
    }
    
    @IBOutlet var userGroupsTable: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableData(data: groupData)
        
        userGroupsTable.delegate = self
        userGroupsTable.dataSource = self
        searchField.delegate = self
        
        let task = NetworkManager()
        task.getGroups()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if((searchField.text) != ""){
            let filteredData = groupData.filter({$0.title.lowercased().contains((searchField.text?.lowercased())!)})
            setTableData(data: filteredData)
        } else {
            setTableData(data: groupData)
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTableData(data: groupData)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userGroupsTable.dequeueReusableCell(withIdentifier: "UserGroupCell") as! UserGroupCell
        
        let index = indexPath.row
        let title = localData[index].title
        let avatar = localData[index].avatar
        
        cell.setData(title: title, avatar: avatar)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = groupData.firstIndex(where: {$0.id == localData[indexPath.row].id})
            
            allGroupData.append(groupData[index!])
            
            groupData.remove(at: index!)
            
            localData.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
