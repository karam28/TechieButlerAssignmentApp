//
//  PostModel.swift
//  TechieButlerAssignmentApp
//
//  Created by Karamjeet Singh on 26/04/24.
//

import Foundation

// MARK: - PostModel
struct PostModel: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    // Function to count the properties
    func countProperties<T: Codable>(of type: T.Type) -> Int {
        let mirror = try? Mirror(reflecting: type.init(from: PostModel.self as! Decoder))
        return mirror?.children.count ?? 4
    }
}
