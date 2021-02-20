//
//  AllGroupsController.swift
//  geekbrains-vkapp
//
//  Created by David Dakhovich on 06/02/2021.
//

import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {

    var localData = [Group]()
    
    @IBOutlet var allGroupsTabel: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    
    
    func setTableData(data: [Group]){
        localData.removeAll()
        localData.append(contentsOf: data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableData(data: allGroupData)

        allGroupsTabel.delegate = self
        allGroupsTabel.dataSource = self
        searchField.delegate = self
        
        let task = NetworkManager()
        task.getAllGroups { (groups) in
            if (groups.count > 0) {
                for group in groups {
                    allGroupData.append(Group(id: group.id, title: group.name, avatar: group.photo_50))
                }
            } else {
                allGroupData.append(Group(id: 0, title: "You have no groups", avatar: nil))
            }
            
            DispatchQueue.main.async {
                self.setTableData(data: allGroupData)
                self.tableView.reloadData()
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchField.text != "") {
            let task = NetworkManager()
            task.findGroup(value: searchField.text) { (groups) in
                var foundedGroups: [Group] = []
                if (groups.count > 0) {
                    for group in groups {
                        foundedGroups.append(Group(id: group.id, title: group.name, avatar: group.photo_50))
                    }
                } else {
                    foundedGroups.append(Group(id: 0, title: "Group not found", avatar: nil))
                }
                
                DispatchQueue.main.async {
                    self.setTableData(data: foundedGroups)
                    self.tableView.reloadData()
                }
            }
        } else {
            self.setTableData(data: allGroupData)
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTableData(data: allGroupData)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allGroupsTabel.dequeueReusableCell(withIdentifier: "AllGroupCell") as! AllGroupCell
        
        let index = indexPath.row
        let title = localData[index].title
        let avatar = localData[index].avatar
        
        cell.setData(title: title, avatar: avatar)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let addAction = UIContextualAction(style: .normal, title: "Add") {(action, view, completion) in
            let index = allGroupData.firstIndex(where: {$0.id == self.localData[indexPath.row].id})
            groupData.append(allGroupData[index!])
            
            allGroupData.remove(at: index!)
            
            self.localData.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    
        addAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [addAction])
    }
}
