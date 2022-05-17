//
//  ContactView.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 19.03.2022.
//

import UIKit

class ContactsView: UIView {
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupNSAutolayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    let contactsTableView: UITableView = {
        let contactsTableView = UITableView(frame: .zero, style: .grouped)
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        contactsTableView.contentInsetAdjustmentBehavior = .always
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        contactsTableView.tableHeaderView = UIView(frame: frame)
        
        contactsTableView.allowsSelection = true
        contactsTableView.isScrollEnabled = true
        contactsTableView.backgroundColor = .clear
        contactsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        return contactsTableView
    }()
     
    
}
extension ContactsView {
    
    func setupViews() {
        addSubview(contactsTableView)
    }
    
    func setupNSAutolayoutConstraints() {
        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            contactsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            contactsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            contactsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
    }
}

