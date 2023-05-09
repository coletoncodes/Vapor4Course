import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    
    app.databases.use(
        .postgres(
            hostname: "localhost",
            username: "postgres",
            password: "",
            database: "moviesdb"
        ),
        as: .psql
    )
    
    app.migrations.add(CreateMovie(), to: .psql)
    app.migrations.add(CreateReview(), to: .psql)
    
    // register routes
    try routes(app)
}
