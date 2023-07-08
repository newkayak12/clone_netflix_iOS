//
//  File.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
struct File: Codable {
    private var fileNo: Int
    private var tableNo: Int
    private var fileType: FileType
    private var storedFileName: String
    private var originalFileName: String
    private var orders: Int
    private var contentType: String
    private var fileSize: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fileNo = try container.decode(Int.self, forKey: .fileNo)
        self.tableNo = try container.decode(Int.self, forKey: .tableNo)
        self.fileType = try container.decode(FileType.self, forKey: .fileType)
        self.storedFileName = try container.decode(String.self, forKey: .storedFileName)
        self.originalFileName = try container.decode(String.self, forKey: .originalFileName)
        self.orders = try container.decode(Int.self, forKey: .orders)
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
