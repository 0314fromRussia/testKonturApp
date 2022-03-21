//
//  ContactDetailViewController.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 20.03.2022.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    let contactDetailView = ContactDetailView()
    
    var num: String?
    
    override func loadView() {
        view = contactDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        contactDetailView.phoneButton.addTarget(self, action: #selector(toCall), for: .touchUpInside)
    }
    
    init(name: String, phone: String, bio: String, temperament: String, period: EducationPeriod) {
        
        contactDetailView.biographyLabel.text = bio
        num = phone
        contactDetailView.phoneButton.setTitle(phone, for: .normal)
        contactDetailView.nameLabel.text = name
        contactDetailView.temperamentLabel.text = temperament
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd.MM.yyyy"
        let end = dateformatter.string(from: period.end)
        let start = dateformatter.string(from: period.start)
        
        contactDetailView.dateLabel.text = "\(start) - \(end)"
        super.init(nibName: nil, bundle: nil)
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toCall() {
        
        if let url = URL(string: "tel://\(String(describing: num?.filter { !" -+()".contains($0) }))") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                                            print(success)})
            } else {
                let success = UIApplication.shared.openURL(url)
                print(success)
            }
        }
    }

    
    
}
