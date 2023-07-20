//
//  SearchResultViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/20.
//

import Foundation
class SearchResultViewModel: ViewModelType {
    var title: String
    var service: Service
    
    init( title: String, service: Service ) {
        self.title = title
        self.service = service
    }
}
