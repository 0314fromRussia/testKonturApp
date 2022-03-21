//
//  AppDatabase.swift
//  KonturApp
//
//  Created by Никита Дмитриев on 20.03.2022.
//


import Foundation
import GRDB

class AppDatabase {
    
    init(_ databaseWriter: DatabaseWriter) throws {
        self.databaseWriter = databaseWriter
        try migrator.migrate(databaseWriter)
    }
    
    let databaseWriter: DatabaseWriter
    
    var databaseReader: DatabaseReader {
        databaseWriter
    }
    
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("createContact") { db in
            
            try db.create(table: "DBModel") { contact in
                contact.column("id", .text).notNull().unique()
                contact.column("name", .text).notNull()
                contact.column("phone", .text).notNull()
                contact.column("height", .double).notNull()
                contact.column("biography", .text).notNull()
                contact.column("temperament", .text).notNull()
                contact.column("start", .date).notNull()
                contact.column("end", .date).notNull()
                
            }
        }
        return migrator
    }
    
    func createContacts(_ dataContact: [DBModel]) -> [ContactModel] {
        var contacts: [ContactModel] = []
        for contact in dataContact {
            let cont = ContactModel(id: contact.id, name: contact.name, phone: contact.phone, height: contact.height, biography: contact.biography, temperament: contact.temperament, educationPeriod: EducationPeriod(start: contact.start, end: contact.end))
            contacts = contacts.uniqued()
            contacts.append(cont)
        }
        return contacts
    }
    
    func saveContact(_ contact: inout ContactModel) throws {
        var cont = DBModel(id: contact.id, name: contact.name, phone: contact.phone, height: contact.height, biography: contact.biography, temperament: contact.temperament, start: contact.educationPeriod.start, end: contact.educationPeriod.end)
        try databaseWriter.write { database in
            
            
            do {
                if try !cont.exists(database) {
                    try cont.save(database)
                } else {
                    print("contact exists")
                }
            } catch {
                
            }
            
        }
    }
    
    func readContacts() -> [DBModel] {
        let contacts: [DBModel] = try! databaseReader.read({ database in
            try DBModel.fetchAll(database)
        })
        return contacts
    }
    
    
}

extension AppDatabase {
    static let shared = makeShared()
    
    private static func makeShared() -> AppDatabase {
        do {
            let fileManager = FileManager()
            
            let url = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
            let baseURL = url.appendingPathComponent("database.sqlite")
            let databasePool = try DatabasePool(path: baseURL.path)
            
            let db = try AppDatabase(databasePool)
            
            return db
            
        } catch let error {
            fatalError("\(error.localizedDescription)")
        }
    }
}
