//
//  CreateMovieActor.swift
//  
//
//  Created by Coleton Gorecke on 5/8/23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovieActor: AsyncMigration {
    
    // The up migration, creating a table.
    func prepare(on database: Database) async throws {
        try await database
            .schema(MovieActor.schema)
            .id()
            .field(
                "movie_id",
                .uuid,
                .required,
                .references(Movie.schema, .id))
            .field(
                "actor_id",
                .uuid,
                .required,
                .references(Actor.schema, .id))
            .create()
    }
    
    // Performed at the end of the migration, undo
    func revert(on database: Database) async throws {
        // Drop the table
        try await database
            .schema(MovieActor.schema)
            .delete()
    }
}

