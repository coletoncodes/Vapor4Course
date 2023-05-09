//
//  MoviesControllerTests.swift
//  
//
//  Created by Coleton Gorecke on 5/4/23.
//

@testable import App
import XCTVapor

@MainActor
final class MovieControllerTests: XCTestCase {
    var app: Application!

    override func setUp() async throws {
        app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)
    }

    override func tearDown() {
        app.shutdown()
    }

    func testGetMovies() async throws {
        try app.test(.GET, "movies", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            // Add additional assertions if needed
        })
    }

    func testGetMovie() async throws {
        // Create a test movie
        let movie = Movie(id: UUID(), title: "Test Movie")
        try await movie.save(on: app.db)

        try app.test(.GET, "movie/\(movie.id!)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let responseMovie = try res.content.decode(Movie.self)
            XCTAssertEqual(movie, responseMovie)
        })
    }

    func testCreateMovie() async throws {
        let movie = Movie(title: "Test Movie")
        try app.test(.POST, "movies", beforeRequest: { req in
            try req.content.encode(movie)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let responseMovie = try res.content.decode(Movie.self)
            XCTAssertEqual(movie.title, responseMovie.title)
        })
    }

    func testUpdateMovie() async throws {
        // Create a test movie
        let movie = Movie(id: UUID(), title: "Test Movie")
        try await movie.save(on: app.db)

        let updatedMovie = Movie(id: movie.id, title: "Updated Test Movie")
        try app.test(.PUT, "movies", beforeRequest: { req in
            try req.content.encode(updatedMovie)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let responseMovie = try res.content.decode(Movie.self)
            XCTAssertEqual(movie.title, responseMovie.title)
        })
    }

    func testDeleteMovie() async throws {
        // Create a test movie
        let movie = Movie(title: "Test Movie")
        try await movie.save(on: app.db)

        try app.test(.DELETE, "movie/\(movie.id!)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            // Add additional assertions if needed
        })
    }
}

