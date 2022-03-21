//
//  ErrorView.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 21.03.2022.
//

import UIKit

class ErrorView {
    
var alert: UIView!

func setupErrorView() {
    let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })!
    
    alert = UIView(frame: CGRect(origin: CGPoint(x: window.frame.midX - 150, y: window.frame.maxY - 150), size: CGSize(width: 300, height: 48)))
    alert.backgroundColor = .black
    alert.layer.cornerRadius = 8
    alert.alpha = 0

    
    let label = UILabel()
    label.text = "Нет подключения к сети"
    label.font = UIFont(name: "System", size: 16)
    label.textColor = .white
    label.textAlignment = .center
    label.frame = CGRect(origin: .zero, size: alert.frame.size)
    
    alert.addSubview(label)
    
    window.addSubview(alert)

    
    UIView.animate(withDuration: 3, animations: {[weak self] in self?.alert.alpha = 0.5},
                   completion: { _ in self.hide()})

   
}
    func hide() {
        UIView.animate(withDuration: 3, animations: {[weak self] in self?.alert.alpha = 0})
        alert.removeFromSuperview()
    }
    
}
