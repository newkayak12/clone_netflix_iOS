//
//  TabBarViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
import UIKit
class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        let service = Service.shared
        
        let symbolConfiguration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        
        
        let homeImg  = UIImage(systemName: "house", withConfiguration: symbolConfiguration)
        let searchImg = UIImage(systemName: "magnifyingglass", withConfiguration: symbolConfiguration)
        let starImg = UIImage(systemName: "star", withConfiguration: symbolConfiguration)
        let myImg = UIImage(systemName: "tray", withConfiguration: symbolConfiguration)
        
        
        
        var homeView = HomeViewController();
        let homeViewModel = HomeViewModel(title: "Main", service: service )
        homeView.bind(viewModel: homeViewModel)
        let home = UINavigationController(rootViewController: homeView)
        
        var searchView = SearchViewController()
        let searchViewModel = SearchViewModel(title: "Search", service: service)
        searchView.bind(viewModel: searchViewModel)
        let search = UINavigationController(rootViewController: searchView)
        
        var starView = StarViewController()
        let starViewModel = StarViewModel(title: "Star", service: service)
        starView.bind(viewModel: starViewModel)
        let star = UINavigationController(rootViewController: starView)
        
        var myView = MyViewController()
        let myViewModel = MyViewModel(title: "My", service: service)
        myView.bind(viewModel: myViewModel)
        let my = UINavigationController(rootViewController: myView)
        
        
        home.tabBarItem.title = "홈"
        home.tabBarItem.image = homeImg
        
        search.tabBarItem.title = "찾기"
        search.tabBarItem.image = searchImg
        
        star.tabBarItem.title = "평가"
        star.tabBarItem.image = starImg
        
        my.tabBarItem.title = "보관함"
        my.tabBarItem.image = myImg
        
        viewControllers = [home, search, star, my]
        tabBar.backgroundColor = .black
        tabBar.barStyle = .black
        
    }
}
