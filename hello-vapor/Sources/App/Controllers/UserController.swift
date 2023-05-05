//
//  UserController.swift
//
//
//  Created by Coleton Gorecke on 5/3/23.
//

import Foundation
import Vapor

struct User: Content {
    let id: String
    let name: String
    let age: Int
}

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let usersGroup = routes.grouped("users")
        
        // MARK: - GET
        // http://127.0.0.1:8080/users/:user_id
        usersGroup.get(":user_id", use: getUserByID)
        
        // MARK: - POST
        // http://127.0.0.1:8080/users
        usersGroup.post(use: postNewUser)
    }
    
    // MARK: - GET
    func getUserByID(req: Request) throws -> User {
        guard let userID = req.parameters.get("user_id") else {
            throw Abort(.badRequest)
        }

        return User(id: userID, name: "Test User", age: 24)
    }
    
    // MARK: - POST
    func postNewUser(req: Request) throws -> HTTPStatus {
        do {
            let newUser = try req.content.decode(User.self)
            // add to database probably
            print(newUser)
        } catch {
            return .internalServerError
        }

        return .ok
    }
}
