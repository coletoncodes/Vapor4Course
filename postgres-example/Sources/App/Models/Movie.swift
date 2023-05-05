//
//  Movie.swift
//  
//
//  Created by Coleton Gorecke on 5/4/23.
//

import Fluent
import Vapor

final class Movie: Model, Content {
    // Table name
    static let schema = "movies"
    
    // Primary key
    @ID(key: .id)
    var id: UUID?

    // Matches title column in database
    @Field(key: "title")
    var title: String
    
    init() { }

    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}

