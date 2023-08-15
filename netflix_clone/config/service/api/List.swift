//
//  Api.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/15.
//

import Foundation

struct UserApi {
    static let PREFIX = "/api/v1/user"
    
    static let signIn = "\(UserApi.PREFIX)/sign/in"
    static let signUp = "\(UserApi.PREFIX)/sign/up"
    static let checkPassword = "\(UserApi.PREFIX)/change/password"
    static func checkId (userId: Int) -> String { return "\(UserApi.PREFIX)/check/id/\(userId)" }
    
}

struct ProfileApi {
    static let PREFIX = "/api/v1/profile"
    
    let profiles = "\(ProfileApi.PREFIX)/"
    func profile ( profileNo: Int ) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)"}
    let  saveProfile = "\(ProfileApi.PREFIX)/save"
    func changeProfileName ( profileNo: Int) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)/profileName" }//changeProfileName
    func changePushState ( profileNo: Int) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)/isPush" } //changePushState
    func changeProfileImage ( profileNo: Int) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)/profileImage" } //changeProfileImage
    func removeProfile ( profileNo: Int) -> String { return "\(ProfileApi.PREFIX)/\(profileNo)" } //removeProfile
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
