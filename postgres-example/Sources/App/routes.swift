import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // /movies
    app.get("movies") { req async throws -> [Movie] in
        try await Movie.query(on: req.db).all()
    }
    
    // /movie/id
    app.get("movie", ":movie_id") { req async throws -> Movie in
        guard let movie = try await Movie.find(req.parameters.get("movie_id"), on: req.db) else {
            throw Abort(.notFound, reason: "Invalid or missing movie_id")
        }
        
        return movie
    }
    
    // /movies POST
    app.post("movies") { req -> Movie in
        // Decode movie
        // Content = body of HTTP request
        let movie = try req.content.decode(Movie.self)
        // After creating in database, return the Model.
        // This is optional, you could return .ok or whatever else you wanted.
        try await movie.create(on: req.db)
        return movie
    }
}
