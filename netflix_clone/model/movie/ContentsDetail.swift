//
//  ContentsDetail.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class ContentDetail: Codable {
    
    var detailNo: Int
    var season: Int
    var episode: Int
    var subTitle: String
    var duration: Date
    var storedLocation: String
    var contentsInfo: ContentsInfo
    var thumbnail: File
    var watched: Watched
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.detailNo = try container.decode(Int.self, forKey: .detailNo)
        self.season = try container.decode(Int.self, forKey: .season)
        self.episode = try container.decode(Int.self, forKey: .episode)
        self.subTitle = try container.decode(String.self, forKey: .subTitle)
        self.duration = try container.decode(Date.self, forKey: .duration)
        self.storedLocation = try container.decode(String.self, forKey: .storedLocation)
        self.contentsInfo = try container.decode(ContentsInfo.self, forKey: .contentsInfo)
        self.thumbnail = try container.decode(File.self, forKey: .thumbnail)
        self.watched = try container.decode(Watched.self, forKey: .watched)
    }
}
