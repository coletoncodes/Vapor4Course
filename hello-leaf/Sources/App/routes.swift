import Vapor

struct Context: Content {
    let name: String
}

func routes(_ app: Application) throws {
    
    // Root Route
    app.get { req async throws -> View in
        try await req.view.render("index")
    }
    
//    // /app
//    app.get("app") { req async throws -> View in
//        try await req.view.render("app")
//    }
}
