import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    
    // Setup Database
    app.databases.use(
        .postgres(
            hostname: "localhost",
            username: "coletongorecke",
            password: "",
            database: "postgres"
        ),
        as: .psql
    )
    
    app.migrations.add(CreateMovie(), to: .psql)
    app.migrations.add(CreateReview(), to: .psql)
    app.migrations.add(CreateActor(), to: .psql)
    app.migrations.add(CreateMovieActor(), to: .psql)
    
    
    // register routes
    try routes(app)
}
