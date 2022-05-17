//
//  ContactTableViewCell.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 19.03.2022.
//

import UIKit


class ContactTableViewCell: UITableViewCell {
    
     let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
      
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
     let phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textColor = .lightGray
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return phoneLabel
    }()
    
     let temperamentLabel: UILabel = {
        let temperamentLabel = UILabel()
        temperamentLabel.textColor = .lightGray
        temperamentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return temperamentLabel
    }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(temperamentLabel)
        
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: temperamentLabel.leadingAnchor, constant: -6),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220)
        ])
        
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            temperamentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            temperamentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


