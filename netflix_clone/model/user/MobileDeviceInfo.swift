//
//  MobileDeviceInfo.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
final class MobileDeviceInfo: Codable {
    var deviceType: String
    var pushKey: String
    var uuid: String
    var osVersion: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.deviceType = try container.decode(String.self, forKey: .deviceType)
        self.pushKey = try container.decode(String.self, forKey: .pushKey)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.osVersion = try container.decode(String.self, forKey: .osVersion)
    }
}
