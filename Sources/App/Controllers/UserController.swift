//
//  UserController.swift
//  
//
//  Created by Coleton Gorecke on 5/3/23.
//

import Foundation
import Vapor

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
    func getUserByID(req: Request) throws -> String {
        guard let userID = req.parameters.get("user_id") else {
            throw Abort(.badRequest)
        }

        return "User's ID is \(userID)"
    }
    
    // MARK: - POST
    func postNewUser(req: Request) throws -> HTTPStatus {
        // Guard that body params are correct and can decode into model, else throw error.
        return .ok
    }
}
