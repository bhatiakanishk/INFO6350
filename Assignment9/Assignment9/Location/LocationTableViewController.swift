//
//  LocationTableViewController.swift
//  Assignment9
//
//  Created by Kanishk Bhatia on 11/17/22.
//

import UIKit

class LocationTableViewController: UITableViewController {

    var mainVC: ViewController?
    let searchController = UISearchController(searchResultsController: nil) // if nil, use same tableview controller to show the result
    
    var filteredResults: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Location Menu"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type to search"
        navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredResults = mainVC?.locations ?? []
        tableView.reloadData()
    }
    
    @objc func addTapped(_ sender:Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "LocationDetailsVC") as? LocationDetailsViewController {
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "LocationCell")
        cell.textLabel?.text = filteredResults[indexPath.row].street
        cell.detailTextLabel?.text = "\(filteredResults[indexPath.row].state), \(filteredResults[indexPath.row].country)"
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let mainVC = mainVC {
            let locationId = mainVC.locations[indexPath.row].id
            let orders = mainVC.logisticsOrder.filter( {$0.toLocation.id == locationId || $0.fromLocation.id == locationId} )
            if orders.count > 0 {
                // error
                showAlert(title: "Cannot Delete", message: "This location is being used in an order.")
                
            } else {
                // no order using these location -> DELETE
                let item = mainVC.locations[indexPath.row]
                // Delete the row from the data source
                mainVC.locations.remove(at: indexPath.row)
                
                //Delete record in the database
                DatabaseManager.shared.deleteRecord(type: Location.self, id: item.id)

                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !searchController.isActive
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "LocationDetailsVC") as? LocationDetailsViewController {
            vc.mainVC = mainVC
            vc.vcMode = .modify
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
extension LocationTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, let mainVC = mainVC else { return }
        
        if text.isEmpty {
            filteredResults = self.mainVC?.locations ?? []
        } else {
            filteredResults = mainVC.locations.filter( { $0.street.lowercased().contains(text.lowercased()) || $0.city.lowercased().contains(text.lowercased()) ||
                $0.state.lowercased().contains(text.lowercased()) ||
                $0.country.lowercased().contains(text.lowercased()) ||
                $0.zip.contains(text) } )
        }
        tableView.reloadData()
    }
}

extension LocationTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.filteredResults = self.mainVC?.locations ?? []
            self.tableView.reloadData()
        }
    }
}
