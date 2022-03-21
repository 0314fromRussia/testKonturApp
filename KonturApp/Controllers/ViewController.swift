//
//  ViewController.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 19.03.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let contactsView = ContactsView()
    
    var contacts: [ContactModel] = []
    var searchData: [ContactModel] = []
    
    override func loadView() {
        view = contactsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsView.contactsTableView.delegate = self
        contactsView.contactsTableView.dataSource = self
        contactsView.contactsTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "cell")
        
        setupNavigationBar()
        setupSearchController()
        configureRefreshControl()
        fetchData()
    }
    
    func setupNavigationBar() {
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureRefreshControl() {
        contactsView.contactsTableView.refreshControl = UIRefreshControl()
        contactsView.contactsTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        
        DispatchQueue.main.async {
            self.fetchData()
            
            self.contactsView.contactsTableView.refreshControl?.endRefreshing()
        }
        
    }
    
    
    func fetchData() {
        
        var updateData: Bool {
            
            let lastUpdated = UserDefaults.standard.object(forKey: "lastUpdated")
            if let lastUpdated = lastUpdated as? Date {
                return Date().timeIntervalSince(lastUpdated) > 60 ? true : false
            }
            return true
        }
        
        
        if updateData {
            
            let networkService = NetworkService()
            let urls = [APIEnumURL.one.getURL(),APIEnumURL.two.getURL(), APIEnumURL.three.getURL()]
            
            for url in urls {
                networkService.getData(url: url) { [self] (response: [ContactModel]?, data: Data?) in
                    
                    guard let response = response else { return }
                    
                    DispatchQueue.main.async {
                        
                        for i in response {
                            var contact = i
                            try! AppDatabase.shared.saveContact(&contact)
                            contacts.append(i)
                        }
                        contacts = contacts.uniqued()
                        contacts = contacts.sorted { $0.name < $1.name }
                        searchData = contacts
                        
                        self.contactsView.contactsTableView.reloadData()
                        UserDefaults.standard.set(Date(), forKey: "lastUpdated")
                        contactsView.isUserInteractionEnabled = true
                        
                    }
                }
            }
            
            
        } else {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let models = AppDatabase.shared.readContacts()
                self?.contacts = AppDatabase.shared.createContacts(models)
                
            }
            
            DispatchQueue.main.async {
                self.contacts = self.contacts.uniqued()
                self.contacts = self.contacts.sorted { $0.name < $1.name }
                self.searchData = self.contacts 
                self.contactsView.contactsTableView.reloadData()
                
                self.contactsView.isUserInteractionEnabled = true
            }
        }
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func setupSearchController() {
        contactsView.searchController.searchResultsUpdater = self
        contactsView.searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        contactsView.searchController.searchBar.placeholder = "Search"
        
        contactsView.searchController.searchBar.tintColor = .black
        contactsView.searchController.searchBar.barTintColor = .gray
        
        navigationItem.searchController = contactsView.searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterResults(for: searchController.searchBar.text ?? "")
    }
    func filterResults(for searchText: String) {
        
        if searchText == "" {
            contacts = searchData
        } else {
            contacts = searchData.filter {
                ($0.name.lowercased().contains(searchText.lowercased())) || ($0.phone.lowercased().contains(searchText.lowercased()))
            }
        }
        contactsView.contactsTableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.nameLabel.text = contacts[indexPath.row].name
        let userPhone = String(contacts[indexPath.row].phone.filter { !"()".contains($0) })
        cell.phoneLabel.text = userPhone
        cell.temperamentLabel.text = contacts[indexPath.row].temperament.rawValue
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = ContactDetailViewController(name: contacts[indexPath.row].name, phone: contacts[indexPath.row].phone, bio: contacts[indexPath.row].biography, temperament: contacts[indexPath.row].temperament.rawValue, period: contacts[indexPath.row].educationPeriod)
        let viewController = detailViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
