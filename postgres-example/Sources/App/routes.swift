import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // MARK: - GET
    // /movies
    app.get("movies") { req async throws -> [Movie] in
        try await Movie.query(on: req.db)
            .with(\.$reviews)
            .with(\.$actors)
            .all()
    }
    
    // /movie/id
    app.get("movie", ":movie_id") { req async throws -> Movie in
        guard let movie = try await Movie.find(req.parameters.get("movie_id"), on: req.db) else {
            throw Abort(.notFound, reason: "Invalid or missing movie_id")
        }
        
        return movie
    }
    
    // MARK: - POST
    // /movies
    app.post("movies") { req async throws -> Movie in
        // Decode movie
        // Content = body of HTTP request
        let movie = try req.content.decode(Movie.self)
        // After creating in database, return the Model.
        // This is optional, you could return .ok or whatever else you wanted.
        try await movie.create(on: req.db)
        return movie
    }
    
    // MARK: - PUT
    // /movies
    app.put("movies") { req async throws -> HTTPStatus in
        let movieBody = try req.content.decode(Movie.self)
        
        if let existingMovie = try await Movie.find(movieBody.id, on: req.db) {
            existingMovie.id = movieBody.id
            existingMovie.title = movieBody.title
            try await existingMovie.update(on: req.db)
            req.logger.info("Successfully updated movie")
            return .ok
        } else {
            throw Abort(.notFound, reason: "Invalid or missing movie_id")
        }
    }
    
    // MARK: - Delete
    // /movie/:movie_id
    app.delete("movie", ":movie_id") { req async throws -> HTTPStatus in
        guard let movieToDelete = try await Movie.find(req.parameters.get("movie_id"), on: req.db) else {
            throw Abort(.notFound, reason: "Unable to find Movie. Invalid or missing movie_id")
        }
        
        // Delete the movie from the database
        try await movieToDelete.delete(on: req.db)
        req.logger.info("Successfully deleted movie")
        return .ok
    }
    
    // MARK: - Reviews
    // /reviews
    app.post("reviews") { req async throws -> HTTPStatus in
        let review = try req.content.decode(Review.self)
        try await review.create(on: req.db)
        req.logger.info("Successfully added review to movie")
        return .ok
    }
    
    // MARK: - Actors
    // /actors
    app.post("actors") { req async throws -> HTTPStatus in
        let actor = try req.content.decode(Actor.self)
        try await actor.create(on: req.db)
        req.logger.info("Successfully created actor")
        return .ok
    }
    
    /// GET
    // /actors
    app.get("actors") { req async throws -> [Actor] in
        try await Actor
            .query(on: req.db)
            .with(\.$movies)
            .all()
    }
    
    // MARK: - MovieActor
    // /movie/:movie_id/actor/:actor_id
    app.post("movie", ":movie_id", "actor", ":actor_id") { req async throws -> HTTPStatus in
        guard let movieID = req.parameters.get("movie_id", as: UUID.self), let actorID = req.parameters.get("actor_id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        // get the movie
        guard let movie = try await Movie.find(movieID, on: req.db) else {
            throw Abort(.notFound, reason: "A Movie with the id: \(movieID) does not exist")
        }
        
        guard let actor = try await Actor.find(actorID, on: req.db) else {
            throw Abort(.notFound, reason: "An actor with the id: \(actorID) does not exist")
        }
        
        try await movie.$actors.attach(actor, on: req.db)
        
        return .ok
    }
}
