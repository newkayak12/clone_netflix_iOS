//
//  Board.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class Banner: Codable {
    var bannerNo: Int
    var title: String
    var url: String
    var image: File?
    
    init() {
        bannerNo = 0
        title = ""
        url = ""
        image = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bannerNo = try container.decode(Int.self, forKey: .bannerNo)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.image = try container.decode(File.self, forKey: .image)
    }
}
