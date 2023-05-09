//
//  MovieActor.swift
//
//
//  Created by Coleton Gorecke on 5/8/23.
//

import Fluent
import Vapor

final class MovieActor: Model {
    // MARK: - Table name
    static let schema = "movie_actors"
    
    // MARK: - Primary key
    @ID(key: .id)
    var id: UUID?

    // MARK: - Properties
    @Parent(key: "actor_id")
    var actor: Actor
    
    @Parent(key: "movie_id")
    var movie: Movie
    
    // MARK: - Initializers
    
    init() { }

    init(
        id: UUID? = nil,
        actorID: UUID,
        movieID: UUID
    ) {
        self.id = id
        self.$actor.id = actorID
        self.$movie.id = movieID
    }
}
