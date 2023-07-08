//
//  ContentsInfo.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation

final class ContentsInfo: Codable {
    var description: String
    var releaseDate: Date
    var contentType: ContentType
    var duration: String
    var regDate: Date
    var serviceDueDate: Date
    var storedLocation: String
    var watchCount: Int
    var contentPeople: ContentPerson
    var people: Person
    var details: ContentDetail
    var images: [File] = []
    var lastWatchedDate: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        self.releaseDate = try container.decode(Date.self, forKey: .releaseDate)
        self.contentType = try container.decode(ContentType.self, forKey: .contentType)
        self.duration = try container.decode(String.self, forKey: .duration)
        self.regDate = try container.decode(Date.self, forKey: .regDate)
        self.serviceDueDate = try container.decode(Date.self, forKey: .serviceDueDate)
        self.storedLocation = try container.decode(String.self, forKey: .storedLocation)
        self.watchCount = try container.decode(Int.self, forKey: .watchCount)
        self.contentPeople = try container.decode(ContentPerson.self, forKey: .contentPeople)
        self.people = try container.decode(Person.self, forKey: .people)
        self.details = try container.decode(ContentDetail.self, forKey: .details)
        self.images = try container.decode([File].self, forKey: .images)
        self.lastWatchedDate = try container.decode(Date.self, forKey: .lastWatchedDate)
    }
}


enum ContentType: String, Codable {
    case MOVIE = "MOVIE"
    case TV = "TV"
}
