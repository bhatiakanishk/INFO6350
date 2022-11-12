//
//  DatabaseManager.swift
//  Assignment_8
//
//  Created by Kanishk Bhatia on 11/8/22.
//

import Foundation
//Importing GRDB Class
import GRDB

//var dbQueue: DatabaseQueue!

class DatabaseManager {
    //Variable for writing into database
    private let dbWriter: any DatabaseWriter
    
    //Variable for reading from the database
    var dbReader: DatabaseReader {
        dbWriter
    }
    static let shared = makeShared()
    
    //Creating db.sqlite file
    private static func makeShared() -> DatabaseManager {
        do {
            let databaseURL = try FileManager.default
                .url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("db.sqlite")
            print(databaseURL.path)
            
            //dbQueue = try DatabaseQueue(path: databaseURL.path)
            
            //A database pool allows concurrent database accesses.
            let dbPool = try DatabasePool(path: databaseURL.path)
            
            let databaseManager = try DatabaseManager(dbWriter: dbPool)
            return databaseManager
        } catch {
            fatalError("Crashed: \(error)")
        }
    }
    
    init(dbWriter: any DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.eraseDatabaseOnSchemaChange = true
        
        //Creating tables
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
    
    //Creating a generic parameter for flexibility and reusability
    //T - generic type
    
    //Function to save records (write)
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
    
    //Function to fetch records (read)
    func fetchRecords<T: FetchableRecord & TableRecord>(type: T.Type) ->[T] {
        do {
            let records = try dbReader.read { db in
                return try T.fetchAll(db)
            }
            return records
        } catch {
            print("Failed to fetch \(error)")
        }
        return []
    }
    
    //Function to delete records
    func deleteRecord<T: FetchableRecord & TableRecord>(type: T.Type, id: Int) {
        do {
            try _ = dbWriter.write { db in
                try T.deleteOne(db, key: id)
            }
        } catch {
            print("Failed to delete \(error)")
        }
    }
    
    //Functtion to update records
    func updateRecord<T: MutablePersistableRecord>(item: T) {
        do {
            try dbWriter.write { db in
                try item.update(db)
            }
        } catch {
            print("Failed to update \(error)")
        }

    }
}
