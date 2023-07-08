//
//  ContentPerson.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class ContentPerson: Codable {

    var contentPersonNo:Int 
    var contentsInfo: ContentsInfo
    var person: Person
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contentPersonNo = try container.decode(Int.self, forKey: .contentPersonNo)
        self.contentsInfo = try container.decode(ContentsInfo.self, forKey: .contentsInfo)
        self.person = try container.decode(Person.self, forKey: .person)
    }
}
