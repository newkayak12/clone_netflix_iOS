//
//  File.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
struct File: Codable {
    var fileNo: Int
    var tableNo: Int
    var fileType: FileType?
    var storedFileName: String
    var originalFileName: String
    var orders: Int?
    var contentType: String
    var fileSize: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fileNo = try container.decode(Int.self, forKey: .fileNo)
        self.tableNo = try container.decode(Int.self, forKey: .tableNo)
        
        let value = try container.decode(String.self, forKey: .fileType)
        self.fileType = FileType(rawValue: value)
        
        self.storedFileName = try container.decode(String.self, forKey: .storedFileName)
        self.originalFileName = try container.decode(String.self, forKey: .originalFileName)
        self.orders = try? container.decode(Int.self, forKey: .orders)
        self.contentType = try container.decode(String.self, forKey: .contentType)
        self.fileSize = try container.decode(Int.self, forKey: .fileSize)
    }
}

enum FileType: String, Codable {
    case PROFILE = "PROFILE"
    case CONTENTS = "CONTENTS"
    case ACTOR = "ACTOR"
    case DIRECTOR = "DIRECTOR"
    case TICKET = "TICKET"
    case BANNER = "BANNER"
    case NOTIC = "NOTIC"
}
