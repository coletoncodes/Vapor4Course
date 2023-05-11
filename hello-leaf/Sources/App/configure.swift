import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // Allows access to public files, via URL.
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)

    
    // register routes
    try routes(app)
}
