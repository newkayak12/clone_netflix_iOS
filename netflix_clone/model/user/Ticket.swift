//
//  Ticket.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
struct Ticket: Codable {
   
    var ticketNo: Int
    var name: String
    var type: TicketType
    var watchableSimultaneously: Int
    var maximumResolution: Resolution
    var isSupportHDR: Bool
    var savableCount: Int
    var price: Int
    var isActive: Bool
    var image: File
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ticketNo = try container.decode(Int.self, forKey: .ticketNo)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(TicketType.self, forKey: .type)
        self.watchableSimultaneously = try container.decode(Int.self, forKey: .watchableSimultaneously)
        self.maximumResolution = try container.decode(Resolution.self, forKey: .maximumResolution)
        self.isSupportHDR = try container.decode(Bool.self, forKey: .isSupportHDR)
        self.savableCount = try container.decode(Int.self, forKey: .savableCount)
        self.price = try container.decode(Int.self, forKey: .price)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.image = try container.decode(File.self, forKey: .image)
    }
    
}

enum TicketType: String, Codable {
    case BASIC = "BASIC"
    case ADVERTISE_STANDARD = "ADVERTISE_STANDARD"
    case STANDARD = "STANDARD"
    case PREMIUM = "PREMIUM"
}
enum Resolution: String, Codable {
    case HD = "HD"
    case FHD = "FHD"
    case UHD = "UHD"
}
