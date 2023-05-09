//
//  CreateMovie.swift
//  
//
//  Created by Coleton Gorecke on 5/4/23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovie: AsyncMigration {
    
    // The up migration, creating a table.
    func prepare(on database: Database) async throws {
        try await database.schema("movies") // table name
            .id()
            .field("title", .string) // column
            .create()
    }
    
    // Performed at the end of the migration, undo
    func revert(on database: Database) async throws {
        // Drop the table
        try await database.schema("movies").delete()
    }
}
