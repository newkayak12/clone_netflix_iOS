//
//  ProfileViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/25.
//

import Foundation
import RxSwift

class ProfileViewModel: ViewModelType {
    var title: String
    var service: Service
    
    init(title: String, service: Service) {
        self.title = title
        self.service = service
    }
    
}
