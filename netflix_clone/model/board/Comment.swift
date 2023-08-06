//
//  Comment.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class Comment: Codable {
    var commentNo: Int
    var profile: Profile?
    var contentsNo: Int
    var comments: String
    var star: Double
    var regDate: Date
    var modifyDate: Date
    var isDeleted: Bool
    
    init() {
        self.commentNo = 0
        self.profile = nil
        self.contentsNo = 0
        self.comments = ""
        self.star = 3.4
        self.regDate = Date()
        self.modifyDate = Date()
        self.isDeleted = false
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.commentNo = try container.decode(Int.self, forKey: .commentNo)
        self.profile = try container.decode(Profile.self, forKey: .profile)
        self.contentsNo = try container.decode(Int.self, forKey: .contentsNo)
        self.comments = try container.decode(String.self, forKey: .comments)
        self.star = try container.decode(Double.self, forKey: .star)
        self.regDate = try container.decode(Date.self, forKey: .regDate)
        self.modifyDate = try container.decode(Date.self, forKey: .modifyDate)
        self.isDeleted = try container.decode(Bool.self, forKey: .isDeleted)
    }
}
