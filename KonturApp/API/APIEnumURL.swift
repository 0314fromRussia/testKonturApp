//
//  APIEnumURL.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 20.03.2022.
//

import Foundation

fileprivate let prefix = "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/"

enum APIEnumURL: String {
    
    case one = "generated-01.json"
    case two = "generated-02.json"
    case three = "generated-03.json"
    
    func getURL() -> String {
        "\(prefix)\(rawValue)"
    }
}
