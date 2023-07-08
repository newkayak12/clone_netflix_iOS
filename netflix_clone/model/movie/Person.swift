//
//  Person.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class Person: Codable {
    var personNo: Int
    var name: String
    var role: Role
    var file: File
    var contentsInfoList: [ContentsInfo] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.personNo = try container.decode(Int.self, forKey: .personNo)
        self.name = try container.decode(String.self, forKey: .name)
        self.role = try container.decode(Role.self, forKey: .role)
        self.file = try container.decode(File.self, forKey: .file)
        self.contentsInfoList = try container.decode([ContentsInfo].self, forKey: .contentsInfoList)
    }
}


enum Role: String, Codable  {
    case ACTOR = "ACTOR"
    case DIRECTOR = "DIRECTOR"
}
