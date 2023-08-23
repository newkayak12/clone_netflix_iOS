//
//  SelectProfileViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/15.
//

import Foundation
import RxSwift

class SelectProfileViewModel: ViewModelType {
    var title: String
    var service: Service
    
    var profileSubject = BehaviorSubject<[Profile]>(value: [])
    var profile: [Profile] = []
    
    init( title: String, service: Service ) {
        self.service = service
        self.title = title
    }
    
    func fetchProfile( accountNo: Int ) {
        profile.append(contentsOf: [Profile(), Profile()])
        profileSubject.onNext(self.profile)
        
    }
}
