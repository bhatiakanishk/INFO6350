//
//  LogisticOrderTableViewController.swift
//  Assignment9
//
//  Created by Kanishk Bhatia on 11/17/22.
//

import UIKit

class LogisticOrderTableViewController: UITableViewController {
    
    var mainVC: ViewController?
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredResults: [LogisticsOrder] = []

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Logistic Order Menu"

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type to search"
        navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredResults = mainVC?.logisticsOrder ?? []
        tableView.reloadData()
    }
    
    @objc func addTapped(_ sender:Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "LogisticOrderDetailsVC") as? LogisticOrderDetailsViewController {
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "OrderCell")
        let order = filteredResults[indexPath.row]
        cell.textLabel?.text = "\(order.id)"
        cell.detailTextLabel?.text = "Total: \(order.cost), \(dateFormatter.string(from: order.departureDate)) -> \(dateFormatter.string(from: order.estimatedArrivalDate))"
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let mainVC = mainVC {
            let item = mainVC.logisticsOrder[indexPath.row]
            //Deleting record form the database
            DatabaseManager.shared.deleteRecord(type: LogisticsOrder.self, id: item.id)
            
            // Delete the row from the data source
            filteredResults.remove(at: indexPath.row)
            mainVC.logisticsOrder = filteredResults
            
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        if let vc = storyboard.instantiateViewController(withIdentifier: "LogisticOrderDetailsVC") as? LogisticOrderDetailsViewController {
            vc.mainVC = mainVC
            vc.vcMode = .modify
            vc.indexPath = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: Search Delegate
extension LogisticOrderTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, let mainVC = mainVC else { return }
        
        if text.isEmpty {
            filteredResults = self.mainVC?.logisticsOrder ?? []
        } else {
            filteredResults = mainVC.logisticsOrder.filter( {
                dateFormatter.string(from: $0.estimatedArrivalDate).contains(text.lowercased())
                || dateFormatter.string(from: $0.departureDate).contains(text.lowercased())
                || String($0.id).contains(text)
                || $0.fromLocation.street.lowercased().contains(text.lowercased())
                || $0.fromLocation.city.lowercased().contains(text.lowercased())
                || $0.fromLocation.state.lowercased().contains(text.lowercased())
                || $0.fromLocation.country.lowercased().contains(text.lowercased())
                || $0.fromLocation.zip.lowercased().contains(text.lowercased())
                || $0.toLocation.street.lowercased().contains(text.lowercased())
                || $0.toLocation.city.lowercased().contains(text.lowercased())
                || $0.toLocation.state.lowercased().contains(text.lowercased())
                || $0.toLocation.country.lowercased().contains(text.lowercased())
                || $0.toLocation.zip.lowercased().contains(text.lowercased()) } )
        }
        tableView.reloadData()
    }
}

extension LogisticOrderTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.filteredResults = self.mainVC?.logisticsOrder ?? []
            self.tableView.reloadData()
        }
    }
}
