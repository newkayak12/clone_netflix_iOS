//
//  Api.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/15.
//

import Foundation


struct ImageApi {
    static func imgUrl (url: String) -> URL {
        return URL(string: "http://localhost:8080" + url)!
    }
}
struct UserApi {
    static let PREFIX = "/api/v1/user"
    
    static let signIn = "\(UserApi.PREFIX)/sign/in"
    static let signUp = "\(UserApi.PREFIX)/sign/up"
    static let checkPassword = "\(UserApi.PREFIX)/change/password"
    static func checkId (userId: Int) -> String { return "\(UserApi.PREFIX)/check/id/\(userId)" }
    
}

struct ProfileApi {
    static let PREFIX = "/api/v1/profile"
    
    static let profiles = "\(ProfileApi.PREFIX)/"
    static func profile ( profileNo: Int ) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)"}
    static let  saveProfile = "\(ProfileApi.PREFIX)/save"
    static func changeProfileName ( profileNo: Int) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)/profileName" }//changeProfileName
    static func changePushState ( profileNo: Int) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)/isPush" } //changePushState
    static func changeProfileImage ( profileNo: Int) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)/profileImage" } //changeProfileImage
    static func removeProfile ( profileNo: Int) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)" } //removeProfile
}


struct TicketApi {
    static let PREFIX = "/api/v1/ticket"
    
    static let tickets =  "\(TicketApi.PREFIX)/" //tickets
    static func ticket( ticketNo: Int ) -> String  {  return "\(TicketApi.PREFIX)/\(ticketNo)" }//ticket
    static let save = "\(TicketApi.PREFIX)/save" //save
    static func remove( ticketNo: Int ) -> String  {    return "\(TicketApi.PREFIX)/\(ticketNo)"} //remove
    static let raiseTicket =  "\(TicketApi.PREFIX)/raise/ticket" //raiseTicket
    static let raises =  "\(TicketApi.PREFIX)/raises" //raises
    static func toggleSubscribeStatus( userNo: Int ) -> String  {  return "\(TicketApi.PREFIX)/toggle/subscribe/\(userNo)"} //toggleSubscribeStatus
}
