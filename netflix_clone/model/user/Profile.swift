//
//  Profile.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation

struct Profile: Codable {
    var profileNo: Int
    var account: Account
    var regDate: Date
    var isPush: Bool
    var lastSignInDate: Date
    var image: File

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.profileNo = try container.decode(Int.self, forKey: .profileNo)
        self.account = try container.decode(Account.self, forKey: .account)
        self.regDate = try container.decode(Date.self, forKey: .regDate)
        self.isPush = try container.decode(Bool.self, forKey: .isPush)
        self.lastSignInDate = try container.decode(Date.self, forKey: .lastSignInDate)
        self.image = try container.decode(File.self, forKey: .image)
    }
}
