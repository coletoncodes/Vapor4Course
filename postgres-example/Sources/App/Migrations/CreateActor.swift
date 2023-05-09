//
//  CreateActor.swift
//  
//
//  Created by Coleton Gorecke on 5/8/23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateActor: AsyncMigration {
    
    // The up migration, creating a table.
    func prepare(on database: Database) async throws {
        try await database.schema(Actor.schema)
            .id()
            .field("name", .string)
            .create()
    }
    
    // Performed at the end of the migration, undo
    func revert(on database: Database) async throws {
        // Drop the table
        try await database.schema(Actor.schema).delete()
    }
}
