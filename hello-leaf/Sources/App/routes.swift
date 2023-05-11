import Vapor

struct Movie: Content {
    let name: String
}

func routes(_ app: Application) throws {
    
    // Root Route
    app.get { req async throws -> View in
        try await req.view.render("index")
    }
    
    // /add-movie
    app.post("add-movie") { req async throws -> Response in
        let movie = try req.content.decode(Movie.self)
        
        // save to database
        print(movie)
        // redirect to root
        return req.redirect(to: "/")
    }
}
