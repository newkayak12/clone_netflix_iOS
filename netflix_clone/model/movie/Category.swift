//
//  Category.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class Category: Codable {
    var categoryNo: Int
    var parentCategory: Category
    var name: String
    var isLeaf: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categoryNo = try container.decode(Int.self, forKey: .categoryNo)
        self.parentCategory = try container.decode(Category.self, forKey: .parentCategory)
        self.name = try container.decode(String.self, forKey: .name)
        self.isLeaf = try container.decode(Bool.self, forKey: .isLeaf)
    }
}
 
    
