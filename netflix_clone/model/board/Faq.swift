//
//  Faq.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation

final class Faq: Codable {
    var faqNo: Int
    var question: String
    var answer: String
    var regDate: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.faqNo = try container.decode(Int.self, forKey: .faqNo)
        self.question = try container.decode(String.self, forKey: .question)
        self.answer = try container.decode(String.self, forKey: .answer)
        self.regDate = try container.decode(Date.self, forKey: .regDate)
    }
    
}
