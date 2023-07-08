//
//  FavoriteWatched.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class FavoirteWatched: Codable {
    var contentsInfo: ContentsInfo
    var watched: Watched
    var favorite: Favorite
    var lastWatchedDate: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contentsInfo = try container.decode(ContentsInfo.self, forKey: .contentsInfo)
        self.watched = try container.decode(Watched.self, forKey: .watched)
        self.favorite = try container.decode(Favorite.self, forKey: .favorite)
        self.lastWatchedDate = try container.decode(Date.self, forKey: .lastWatchedDate)
    }
}
