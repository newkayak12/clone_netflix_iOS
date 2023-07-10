//
//  PageRequest.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
struct PageRequest: Codable {
    var page: Int
    var limit: Int
    var tableNo: Int?
    
    init ( page: Int = 1 ) {
        self.page = page
        self.limit = 10
        tableNo = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.limit = try container.decode(Int.self, forKey: .limit)
        self.tableNo = try container.decode(Int.self, forKey: .tableNo)
    }
}
