//
//  CreateReview.swift
//  
//
//  Created by Coleton Gorecke on 5/8/23.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

struct CreateReview: AsyncMigration {
    
    // The up migration, creating a table.
    func prepare(on database: Database) async throws {
        try await database.schema("reviews")
            .id()
            .field("title", .string)
            .field("body", .string)
            .field(
                "movie_id",
                .uuid,
                .references("movies", "id")
            )
            .create()
    }
    
    // Performed at the end of the migration, undo
    func revert(on database: Database) async throws {
        // Drop the table
        try await database.schema("reviews").delete()
    }
    
}
