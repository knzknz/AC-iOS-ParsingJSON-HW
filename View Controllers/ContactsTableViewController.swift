//
//  ContactsTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var contactsTableView: UITableView!
    
    var contactsArr = [Person]()
    //var filteredContacts = [Person]()
    
    //For the search bar -> computed property
    var searchText: String?{
        didSet{
            self.contactsTableView.reloadData()
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        loadData()
    }
    
    // MARK: - Load the contacts data from local file
    func loadData() {
        
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            
            let url = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: url){
                let myDecoder = JSONDecoder()
                
                do{
                    let contactInfo = try myDecoder.decode(Contacts.self, from: data)
                    self.contactsArr = contactInfo.results
                    contactsArr.sort(){($0.name.first+$0.name.last) < ($1.name.first+$1.name.last)}
                } catch let error {
                    print(error)
                }
                
            }
            
            //MARK: - Search Bar Methods
            
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                self.searchText = searchText
            }
            
            func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                self.searchText = searchBar.text!
                searchBar.resignFirstResponder()
            }
            
            
            
            
            // MARK: - Table view data source
            
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return contactsArr.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
                //COME BACK TO...
                let selectedContact = contactsArr[indexPath.row]
                cell.textLabel?.text = selectedContact.name.first.capitalized + " " + selectedContact.name.last.capitalized
                cell.detailTextLabel?.text = selectedContact.location.city.capitalized
                cell.imageView?.image = #imageLiteral(resourceName: "profileImage")
                
                return cell
            }
            
            // MARK: - Navigation
            
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let destination = segue.destination as? ContactDetailViewController {
                    destination.contacts = contactsArr[contactsTableView.indexPathForSelectedRow!.row]
                    
                }
            }
        }
        
    }
}
