//
//  ItemsTableViewController.swift
//  Assignment9
//
//  Created by Kanishk Bhatia on 11/17/22.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    var mainVC: ViewController?
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredResults: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Item Menu"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type to search"
        navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredResults = mainVC?.items ?? []
        tableView.reloadData()
    }
    
    @objc func addTapped(_ sender:Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ItemDetailsVC") as? ItemDetailsViewController {
            vc.mainVC = mainVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ItemCell")
        if let imageData = filteredResults[indexPath.row].imageData {
            cell.imageView?.image = UIImage(data: imageData)
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        cell.imageView?.contentMode = .scaleAspectFit
        
        cell.textLabel?.text = filteredResults[indexPath.row].name
        cell.detailTextLabel?.text = "\(filteredResults[indexPath.row].desc), \(filteredResults[indexPath.row].value)"
        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ItemDetailsVC") as? ItemDetailsViewController {
            vc.mainVC = mainVC
            vc.vcMode = .modify
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let mainVC = mainVC {
            let itemId = mainVC.items[indexPath.row].id
            let orders = mainVC.logisticsOrder.filter( { $0.itemsCarried.contains { $0.item.id == itemId }} )
            if orders.count > 0 {
                // error
                showAlert(title: "Cannot Delete", message: "This item is present in an order.")
            } else {
                // no order using these items -> DELETE
                let item = mainVC.items[indexPath.row]
                mainVC.items.remove(at: indexPath.row)
                
                //Create record in the database
                DatabaseManager.shared.deleteRecord(type: Item.self, id: item.id)
                
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !searchController.isActive
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: Search Delegate
extension ItemsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, let mainVC = mainVC else { return }
        
        if text.isEmpty {
            filteredResults = self.mainVC?.items ?? []
        } else {
            filteredResults = mainVC.items.filter( {
                $0.name.lowercased().contains(text.lowercased()) ||
                $0.desc.lowercased().contains(text.lowercased()) ||
                String($0.id).lowercased().contains(text.lowercased()) } )
        }
        tableView.reloadData()
    }
}

extension ItemsTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.filteredResults = self.mainVC?.items ?? []
            self.tableView.reloadData()
        }
    }
}
