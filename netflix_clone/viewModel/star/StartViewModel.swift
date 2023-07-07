//
//  StartViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
import RxSwift

class StarViewModel: ViewModelType {
    var title: String
    var service: Service
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
}
