import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // movies POST
    app.post("movies") { req -> EventLoopFuture<Movie> in
        // Decode movie
        // Content = body of HTTP request
        let movie = try req.content.decode(Movie.self)
        // After creating in database, return the Model.
        // This is optional, you could return .ok or whatever else you wanted. 
        return movie.create(on: req.db).map { movie }
    }
}
