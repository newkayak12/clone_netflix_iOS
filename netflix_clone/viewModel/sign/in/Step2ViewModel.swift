//
//  Step2ViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import Foundation
import RxSwift

class Step2ViewModel: ViewModelType {
    var title: String
    var service: Service
    
    var id: String = ""
    var password: String = ""
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
    func signIn () -> Observable<Account> {
        return service.get(path: UserApi.signIn, params: ["userId": self.id, "userPwd": password], type: Account.self )
    }
}
