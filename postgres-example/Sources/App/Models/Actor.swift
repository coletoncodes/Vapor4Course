//
//  Actor.swift
//  
//
//  Created by Coleton Gorecke on 5/8/23.
//

import Fluent
import Vapor

final class Actor: Model, Content {
    // MARK: - Table name
    static let schema = "actors"
    
    // MARK: - Primary key
    @ID(key: .id)
    var id: UUID?

    // MARK: - Properties
    @Field(key: "name")
    var name: String
    
    // MARK: - Initializers
    
    init() { }

    init(
        id: UUID? = nil,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}
