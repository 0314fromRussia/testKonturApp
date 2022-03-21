//
//  DBModel.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 20.03.2022.
//

import Foundation
import GRDB

struct DBModel: Codable, FetchableRecord, MutablePersistableRecord, TableRecord {
    
    static let id = Column(CodingKeys.id)
    static let name = Column(CodingKeys.name)
    static let phone = Column(CodingKeys.phone)
    static let height = Column(CodingKeys.height)
    static let biography = Column(CodingKeys.biography)
    static let temperament = Column(CodingKeys.temperament)
    static let start = Column(CodingKeys.start)
    static let end = Column(CodingKeys.end)
    
    let id: String
    let name: String
    let phone: String
    let height: Double
    let biography: String
    let temperament: Temperament
    let start: Date
    let end: Date
}
