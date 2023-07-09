//
//  watched.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class Watched: Codable {
    var watchedNo: Int
    var profile: Profile?
    var contentsDetail: ContentDetail?
    var lastWatchedDate: Date
    var watchedAt: String
    
    init() {
        self.watchedNo = 0
        self.lastWatchedDate = Date()
        self.watchedAt = ""
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.watchedNo = try container.decode(Int.self, forKey: .watchedNo)
        self.profile = try container.decode(Profile.self, forKey: .profile)
        self.contentsDetail = try container.decode(ContentDetail.self, forKey: .contentsDetail)
        self.lastWatchedDate = try container.decode(Date.self, forKey: .lastWatchedDate)
        self.watchedAt = try container.decode(String.self, forKey: .watchedAt)
    }
}

 
 
 
 
 

