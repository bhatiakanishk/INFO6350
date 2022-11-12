//
//  DatabaseManager.swift
//  Assignment_7
//
//  Created by Kanishk Bhatia on 11/8/22.
//

import Foundation
import GRDB

//var dbQueue: DatabaseQueue!

class DatabaseManager {
    private let dbWriter: any DatabaseWriter
    var dbReader: DatabaseReader {
        dbWriter
    }
    static let shared = makeShared()
    
    private static func makeShared() -> DatabaseManager {
        do {
            let databaseURL = try FileManager.default
                .url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("db.sqlite")
            print(databaseURL.path)
            
            //dbQueue = try DatabaseQueue(path: databaseURL.path)
            
            let dbPool = try DatabasePool(path: databaseURL.path)
            let databaseManager = try DatabaseManager(dbWriter: dbPool)
            return databaseManager
        } catch {
            fatalError("Crashed xD \(error)")
        }
    }
    
    init(dbWriter: any DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.eraseDatabaseOnSchemaChange = true
        
        migrator.registerMigration("createTable") { db in
            
            try db.create(table: "location") { t in
                t.column("id", .integer).primaryKey()
                t.column("street", .text)
                t.column("city", .text)
                t.column("state", .text)
                t.column("country", .text)
                t.column("zip", .integer)
            }
            
            try db.create(table: "item") { t in
                t.column("id", .integer).primaryKey()
                t.column("name", .text)
                t.column("desc", .text)
                t.column("weight", .integer)
                t.column("value", .integer)
            }
            
            try db.create(table: "logisticsorder") { t in
                t.column("id", .integer).primaryKey()
                t.column("fromLocation", .text)
                t.column("toLocation", .text)
                t.column("estimatedArrivalDate", .date)
                t.column("departureDate", .date)
                t.column("cost", .integer)
                t.column("itemsCarried", .text)
            }
        }
        return migrator
    }
}

extension DatabaseManager {
    //T - generic type
    func saveRecord<T: MutablePersistableRecord>(item: T) {
        var item = item
        do {
            try dbWriter.write { db in
                try item.save(db)
            }
        } catch {
            print("Failed to save \(error)")
        }
    }
        
    func fetchRecords<T: FetchableRecord & TableRecord>(type: T.Type) ->[T] {
        do {
            let records = try dbReader.read { db in
                return try T.fetchAll(db)
            }
            return records
        } catch {
            print("error fetching \(error)")
        }
        return []
    }
    
    func deleteRecord<T: FetchableRecord & TableRecord>(type: T.Type, id: Int) {
        do {
            try _ = dbWriter.write { db in
                try T.deleteOne(db, key: id)
            }
        } catch {
            print("delete failed \(error)")
        }
    }
    
    func updateRecord<T: MutablePersistableRecord>(item: T) {
        do {
            try dbWriter.write { db in
                try item.update(db)
            }
        } catch {
            print("delete failed \(error)")
        }

    }
}
