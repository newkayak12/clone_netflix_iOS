//
//  TabBarViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
import UIKit
import Lottie
class MainViewController: UITabBarController {
    lazy var launchScreen: LottieAnimationView = {
        let animation = LottieAnimationView(name: "netflix")
        
        return animation
    }()
    let service = Service.shared
  
    var homeView = HomeViewController();
    var searchView = SearchViewController()
    var starView = StarViewController()
    var myView = MyViewController()
    
    
    func setLaunchScreen () {
        view.addSubview(launchScreen)
        
        // 2
        launchScreen.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        launchScreen.alpha = 1
        tabBar.isHidden = true
        // 3
        launchScreen.play { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.launchScreen.alpha = 0
            }, completion: { _ in
                self.launchScreen.isHidden = true
                self.launchScreen.removeFromSuperview()
                self.initializeView()
                self.tabBar.isHidden = false
            })
        }
    }
    func initializeView () {
        self.delegate = self
        
        let symbolConfiguration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        
        
        let homeImg  = UIImage(systemName: "house", withConfiguration: symbolConfiguration)
        let searchImg = UIImage(systemName: "magnifyingglass", withConfiguration: symbolConfiguration)
        let starImg = UIImage(systemName: "star", withConfiguration: symbolConfiguration)
        let myImg = UIImage(systemName: "tray", withConfiguration: symbolConfiguration)
        
        
        
        
        let homeViewModel = HomeViewModel(title: "Main", service: service )
        let home = UINavigationController(rootViewController: homeView)
        homeView.bind(viewModel: homeViewModel)
        //        let home = homeView
        
        
        let searchViewModel = SearchViewModel(title: "Search", service: service)
        let search = UINavigationController(rootViewController: searchView)
        searchView.bind(viewModel: searchViewModel)
        //        let search = searchView
        
        
        let starViewModel = StarViewModel(title: "Star", service: service)
        let star = UINavigationController(rootViewController: starView)
        starView.bind(viewModel: starViewModel)
        //        let star = starView
        
        
        let myViewModel = MyViewModel(title: "My", service: service)
        let my = UINavigationController(rootViewController: myView)
        myView.bind(viewModel: myViewModel)
        //        let my = myView
        
        
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
    override func viewDidLoad() {
        self.setLaunchScreen()
    }
}

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        Log.warning(viewController.view as? MyViewController  , "???")
        
        return true;
    }
}
