//
//  Favorite.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class Favorite: Codable {
    
    var favoriteNo: Int
    var profile: Profile?
    var contentsInfo: ContentsInfo?
    var favoriteDate: Date
    
    init(){
        self.favoriteNo = 0
        self.contentsInfo = ContentsInfo()
        self.favoriteDate = Date()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.favoriteNo = try container.decode(Int.self, forKey: .favoriteNo)
        self.profile = try container.decode(Profile.self, forKey: .profile)
        self.contentsInfo = try container.decode(ContentsInfo.self, forKey: .contentsInfo)
        self.favoriteDate = try container.decode(Date.self, forKey: .favoriteDate)
    }
    
}

