//
//  Api.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/15.
//

import Foundation
struct User {
    let prefix = "/api/v1/user"
    
    let signIn = "/api/v1/user/sign/in"
    let signUp = "/api/v1/user/sign/up"
    let checkPassword = "/api/v1/user/change/password"
    func checkId (userId: Int) -> String { return "\(self.prefix)/check/id/\(userId )" }
    
}
