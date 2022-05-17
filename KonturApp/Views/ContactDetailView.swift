//
//  ContactDetailView.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 20.03.2022.
//

import UIKit

class ContactDetailView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupNSAutolayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    let temperamentLabel: UILabel = {
        let temperamentLabel = UILabel()
        temperamentLabel.numberOfLines = 0
        temperamentLabel.textColor = .lightGray
        temperamentLabel.font = UIFont.systemFont(ofSize: 22)
        temperamentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return temperamentLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont.systemFont(ofSize: 19)
        dateLabel.textColor = .lightGray
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateLabel
    }()
    
    let phoneButton: UIButton = {
        let phoneButton = UIButton(type: .system)
        phoneButton.setTitle("", for: .normal)
        phoneButton.setImage(UIImage(named: "phone"), for: .normal)
        phoneButton.tintColor = .link
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        
        return phoneButton
    }()
    
    let biographyLabel: UILabel = {
        let biographyLabel = UILabel()
        biographyLabel.numberOfLines = 0
        biographyLabel.textAlignment = .center
        biographyLabel.textColor = .lightGray
        biographyLabel.font = UIFont.systemFont(ofSize: 17)
        biographyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return biographyLabel
    }()
    
    let topLine: UIView = {
        let topLine = UIView()
        topLine.translatesAutoresizingMaskIntoConstraints = false
        topLine.backgroundColor = .lightGray
        return topLine
    }()
    
    let bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = .lightGray
        return bottomLine
    }()
    
}


extension ContactDetailView {
    func setupViews() {
        
        addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(temperamentLabel)
        scrollView.addSubview(topLine)
        scrollView.addSubview(phoneButton)
        scrollView.addSubview(bottomLine)
        scrollView.addSubview(biographyLabel)
        
        
    }
    func setupNSAutolayoutConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperamentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            temperamentLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: temperamentLabel.bottomAnchor, constant: 30),
            topLine.heightAnchor.constraint(equalToConstant: 1),
            topLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            topLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            phoneButton.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: 20),
            phoneButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            bottomLine.topAnchor.constraint(equalTo: phoneButton.bottomAnchor, constant: 20),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            biographyLabel.topAnchor.constraint(equalTo: bottomLine.bottomAnchor, constant: 30),
            biographyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            biographyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            biographyLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -48)
        ])
        
        
    }
}
