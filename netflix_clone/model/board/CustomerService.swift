//
//  CustomerService.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/08.
//

import Foundation
final class CustomerService: Codable {
    var csNo: Int
    var type: CsType
    var email: String
    var question: String
    var answer: String
    var askedDate: Date
    var replyDate: Date
    var isReplSent: Bool
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.csNo = try container.decode(Int.self, forKey: .csNo)
        self.type = try container.decode(CsType.self, forKey: .type)
        self.email = try container.decode(String.self, forKey: .email)
        self.question = try container.decode(String.self, forKey: .question)
        self.answer = try container.decode(String.self, forKey: .answer)
        self.askedDate = try container.decode(Date.self, forKey: .askedDate)
        self.replyDate = try container.decode(Date.self, forKey: .replyDate)
        self.isReplSent = try container.decode(Bool.self, forKey: .isReplSent)
    }
}

enum CsType: String, Codable {
    case UNSATISFIED = "UNSATISFIED"
    case TOO_MANY_ERRORS = "TOO_MANY_ERRORS"
    case UNCOMFORTABLE = "UNCOMFORTABLE"
    case QUESTION = "QUESTION"
    
    func reason() -> String {
        switch ( self ) {
            case .UNCOMFORTABLE:
                return "이용하기 불편합니다."
            case .TOO_MANY_ERRORS:
                return "에러가 너무 많습니다."
            case .UNSATISFIED:
                return "불만족스럽습니다."
            case .QUESTION:
                return "질문드립니다."
        }
    }
}
