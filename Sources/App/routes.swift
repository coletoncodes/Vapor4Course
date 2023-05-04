import Vapor

// Routes are equivalent to an API Endpoint.
func routes(_ app: Application) throws {
    // http://127.0.0.1:8080
    app.get { req async in
        "This is the root!"
    }
    
    // MARK: - Route Parameters
    // http://127.0.0.1:8080/foo/<foo_id>
    app.get("foo", ":foo_id") { req -> String in
        guard let fooID = req.parameters.get("foo_id") else {
            throw Abort(.badGateway)
        }

        return "FOO WITH \(fooID)"
    }
    
    // MARK: - Anything Routes
    // http://127.0.0.1:8080/foobar/anything
    app.get("foobar", "*") { req -> String in
        "FOOBAR Anything"
    }
    
    // MARK: - CatchALL Routes
    // http://127.0.0.1:8080/foo/bar/**
    // Anything after foo is ok
    app.get("foo", "bar", "**") { req -> String in
        "FOO BAR CATCHALL"
    }
    
    // MARK: - Query Route
    // http://127.0.0.1:8080/search?keyword=toys&page=12
    app.get("search") { req -> String in
        guard let keyword = req.query["keyword"] as String?,
              let page = req.query["page"] as Int? else {
            throw Abort(.badRequest)
        }
        
        return "Keyword is \(keyword) & page number is \(page)"
    }
    
    try app.routes.register(collection: UserController())
}
