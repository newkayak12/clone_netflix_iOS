//
//  PageResult.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/10.
//

import Foundation

struct PageResult <T: Decodable & Encodable> : Codable {
    
    var number: Int = 0
    var size: Int = 10
    var totalElements: Int
    var totalPages: Int
    var numberOfElements:Int
    var last: Bool
    var first: Bool
    var empty: Bool
    var content: [T] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try container.decode(Int.self, forKey: .number)
        self.size = try container.decode(Int.self, forKey: .size)
        self.totalElements = try container.decode(Int.self, forKey: .totalElements)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.numberOfElements = try container.decode(Int.self, forKey: .numberOfElements)
        self.last = try container.decode(Bool.self, forKey: .last)
        self.first = try container.decode(Bool.self, forKey: .first)
        self.empty = try container.decode(Bool.self, forKey: .empty)
        self.content = try container.decode([T].self, forKey: .content)
    }
}
