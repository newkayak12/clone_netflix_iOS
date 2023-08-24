//
//  SelectProfileViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/15.
//

import Foundation
import RxSwift
import NSObject_Rx
import RxCocoa

class SelectProfileViewModel: ViewModelType {
    var title: String
    var service: Service
    let disposeBag: DisposeBag = DisposeBag()
    
    var profileSubject = BehaviorSubject<[Profile]>(value: [])
    var profile: [Profile] = []
    
    init( title: String, service: Service ) {
        self.service = service
        self.title = title
    }
    
    func fetchProfile( accountNo: Int ) {
        
        Log.warning("ACCOUNTNO", accountNo)
        service.get (path: ProfileApi.profiles, params: ["userNo": accountNo], type: [Profile].self)
               .withUnretained(self )
               .subscribe { this, profiles in
                   this.profile.append(contentsOf: profiles)
                   this.profileSubject.onNext(self.profile)
                   Log.debug("PROFILE:::::::::::::", profiles)
               }.disposed(by: disposeBag)
    }
}
