//
//  Review.swift
//  
//
//  Created by Coleton Gorecke on 5/8/23.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

final class Review: Model, Content {
    
    // MARK: - Table Name
    static let schema = "reviews"
    
    // MARK: - Properties
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    // Foreign Key
    @Parent(key: "movie_id")
    var movie: Movie
    
    // MARK: - Initializers
    init() {}
    
    init(
        id: UUID? = nil,
        title: String,
        body: String,
        movieID: UUID
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.$movie.id = movieID
    }
}
