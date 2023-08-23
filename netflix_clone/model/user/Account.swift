//
//  Account.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
final class Account: Codable {
    
    var userNo: Int
    var userId: String
    var userPwd: String
    var regDate: Date
    var isAdult: Bool
    var adultCheckDate: Date
    var mobileNo: String
    var email: String
    var isSubscribed: Bool
    var lastSignDate: Date

    var profiles: [Profile] = []
    var ticketStatus: TicketRaise
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userNo = try container.decode(Int.self, forKey: .userNo)
        self.userId = try container.decode(String.self, forKey: .userId)
        
        let userPwdDecode = try? container.decode(String.self, forKey: .userPwd)
        self.userPwd =  userPwdDecode ?? "";
        
        self.regDate = try container.decode(Date.self, forKey: .regDate)
        self.isAdult = try container.decode(Bool.self, forKey: .isAdult)
        self.adultCheckDate = try container.decode(Date.self, forKey: .adultCheckDate)
        self.mobileNo = try container.decode(String.self, forKey: .mobileNo)
        self.email = try container.decode(String.self, forKey: .email)
        self.isSubscribed = try container.decode(Bool.self, forKey: .isSubscribed)
        self.lastSignDate = try container.decode(Date.self, forKey: .lastSignDate)
        self.profiles = try container.decode([Profile].self, forKey: .profiles)
        self.ticketStatus = try container.decode(TicketRaise.self, forKey:  .ticketStatus)
    }
    
}
