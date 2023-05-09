//
//  Movie.swift
//  
//
//  Created by Coleton Gorecke on 5/4/23.
//

import Fluent
import Vapor

final class Movie: Model, Content {
    // MARK: - Table name
    static let schema = "movies"
    
    // MARK: - Primary key
    @ID(key: .id)
    var id: UUID?

    // MARK: - Properties
    @Field(key: "title")
    var title: String
    
    @Children(for: \.$movie)
    var reviews: [Review]
    
    // MARK: - Initializers
    
    init() { }

    init(
        id: UUID? = nil,
        title: String
    ) {
        self.id = id
        self.title = title
    }
}

// MARK: - Equatable Conformance
extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title
    }
}
