//
//  Notice.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation

final class Notice: Codable {
    var noticeNo: Int
    var title: String
    var content: String
    var regDate: Date
    var images: [File] = []
    
    init(){
        self.noticeNo = 0
        self.title = "TITLE"
        self.content = "CONTENT"
        self.regDate = Date()
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.noticeNo = try container.decode(Int.self, forKey: .noticeNo)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.regDate = try container.decode(Date.self, forKey: .regDate)
        self.images = try container.decode([File].self, forKey: .images)
    }
}
