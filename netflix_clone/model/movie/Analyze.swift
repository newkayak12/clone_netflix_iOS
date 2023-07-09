//
//  Analyze.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class Analyze: Codable {
    
    var analyzeNo: Int
    var contentsInfo: ContentsInfo?
    var title: String
    var subTitle: String
    var description: String
    var category: Category?
    var watchScore: Double
    var favoriteScore: Int
    
    init() {
        self.analyzeNo = 0
        self.contentsInfo = nil
        self.title = "TITLE"
        self.subTitle = "SUBTITLE"
        self.description = "DESCRIPTION"
        self.category = nil
        self.watchScore = 0.0
        self.favoriteScore = 0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.analyzeNo = try container.decode(Int.self, forKey: .analyzeNo)
        self.contentsInfo = try container.decode(ContentsInfo.self, forKey: .contentsInfo)
        self.title = try container.decode(String.self, forKey: .title)
        self.subTitle = try container.decode(String.self, forKey: .subTitle)
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(Category.self, forKey: .category)
        self.watchScore = try container.decode(Double.self, forKey: .watchScore)
        self.favoriteScore = try container.decode(Int.self, forKey: .favoriteScore)
    }
}


