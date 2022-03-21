//
//  ContactModel.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 19.03.2022.
//

import Foundation
import GRDB

enum Temperament: String, Codable {
    
    case sanguine = "sanguine"
    case choleric = "choleric"
    case melancholic = "melancholic"
    case phlegmatic = "phlegmatic"
}

struct ContactModel: Codable, Hashable, FetchableRecord {
    
    let id: String
    let name: String
    let phone: String
    let height: Double
    let biography: String
    let temperament: Temperament
    let educationPeriod: EducationPeriod
}

struct EducationPeriod: Codable, Hashable, FetchableRecord {
    
    let start: Date
    let end: Date
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let startString = try container.decode(String.self, forKey: .start)
        let endString = try container.decode(String.self, forKey: .end)
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        start = dateformatter.date(from: startString) ?? Date()
        end = dateformatter.date(from: endString) ?? Date()
        
    }
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
    
}








