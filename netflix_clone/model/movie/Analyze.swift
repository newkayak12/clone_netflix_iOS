//
//  Analyze.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class Analyze: Codable {
    
    var analyzeNo: Int
    var contentsInfo: ContentsInfo
    var category: Category
    var watchScore: Double
    var favoriteScore: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.analyzeNo = try container.decode(Int.self, forKey: .analyzeNo)
        self.contentsInfo = try container.decode(ContentsInfo.self, forKey: .contentsInfo)
        self.category = try container.decode(Category.self, forKey: .category)
        self.watchScore = try container.decode(Double.self, forKey: .watchScore)
        self.favoriteScore = try container.decode(Int.self, forKey: .favoriteScore)
    }
}


