//
//  Step1ViewModel.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import Foundation
class Step1ViewModel: ViewModelType  {
    var title: String
    var service: Service
    var isBack: Bool = true
    var id: String = ""
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
    
    
}
