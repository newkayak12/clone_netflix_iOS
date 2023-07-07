//
//  TicketRaise.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
struct TicketRaise: Codable {
    var raiseLogNo: Int
    var ticket: Ticket
    var account: Account
    var startDate: Date
    var endDate: Date
    var isActive: Bool
    var subscribeNext: Bool
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.raiseLogNo = try container.decode(Int.self, forKey: .raiseLogNo)
        self.ticket = try container.decode(Ticket.self, forKey: .ticket)
        self.account = try container.decode(Account.self, forKey: .account)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.subscribeNext = try container.decode(Bool.self, forKey: .subscribeNext)
    }
}
