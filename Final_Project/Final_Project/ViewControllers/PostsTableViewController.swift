//
//  PostsTableViewController.swift
//  Final_Project
//
//  Created by Kanishk Bhatia on 12/14/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PostsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var post: [Post] = []
    var filteredPost: [Post] = []
    
    let db = Firestore.firestore()
    
    var isRefreshing: Bool = false
    var isSearchActive: Bool = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        searchBar.delegate = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        isRefreshing = true
        
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isRefreshing = true
        
        fetchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = true
        
        let keyword = Utilities.textInput(searchText.lowercased())
        
        guard keyword.isEmpty == false else{
            filteredPost = post
            tableView.reloadData()
            searchBar.setShowsCancelButton(false, animated: true)
            return
        }
        
        searchBar.setShowsCancelButton(true, animated: true)
        
        filteredPost = post.filter({ $0.title.lowercased().contains(keyword) })
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = true
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        fetchData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    @objc func refreshData() {
        isRefreshing = true
        
        self.post = []
        
        tableView.reloadData()
        
        fetchData()
    }
    
    func fetchData() {
        tableView.refreshControl?.beginRefreshing()
        
        db.collection("posts").order(by: "lastUpdated", descending: true).getDocuments() { (querySnapshot, err) in
            if let error = err {
                print(error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No posts")
                return
            }
            
            self.post = documents.compactMap { queryDocumentSnapshot -> Post? in
                return try? queryDocumentSnapshot.data(as: Post.self)
            }
            
            self.tableView.refreshControl?.endRefreshing()
            self.isRefreshing = false
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
