//
//  MainViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/01.
//

import Foundation
import RxSwift

class HomeViewModel: ViewModelType {
    var title: String
    var service: Service
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
}
