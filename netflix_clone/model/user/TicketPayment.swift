//
//  TicketPayment.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
final class TicketPayment: Codable {
    var payNo: Int
    var account: Account
    var ticket: Ticket
    var raiseLog: TicketRaise
    var originalTransaction: String
    var payDay: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.payNo = try container.decode(Int.self, forKey: .payNo)
        self.account = try container.decode(Account.self, forKey: .account)
        self.ticket = try container.decode(Ticket.self, forKey: .ticket)
        self.raiseLog = try container.decode(TicketRaise.self, forKey: .raiseLog)
        self.originalTransaction = try container.decode(String.self, forKey: .originalTransaction)
        self.payDay = try container.decode(Date.self, forKey: .payDay)
    }
}
