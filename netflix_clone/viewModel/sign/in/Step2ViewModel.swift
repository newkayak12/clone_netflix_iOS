//
//  Step2ViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import Foundation
class Step2ViewModel: ViewModelType {
    var title: String
    var service: Service
    
    var id: String = ""
    var password: String = ""
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
}
