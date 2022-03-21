//
//  NetworkService.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 19.03.2022.
//

import Foundation

enum Links: String {
    
    case one = "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-01.json"
    case two = "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-02.json"
    case three = "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-03.json"
}


struct NetworkService {
    
    func getData<Type: Codable>(url: String, completion: @escaping (Type?, Data?) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error ) in
            
            guard let data = data else { DispatchQueue.main.async {  ErrorView().setupErrorView() }; return }
            let response = try? JSONDecoder().decode(Type.self, from: data)
            completion(response, data)
        }
        dataTask.resume()
    }
}


