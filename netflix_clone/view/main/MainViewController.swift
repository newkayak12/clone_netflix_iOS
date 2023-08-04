//
//  TabBarViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

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
        
        
        
        
        
        let home = UINavigationController(rootViewController: homeView)
        let homeViewModel = HomeViewModel(title: "Main", service: service )
        homeView.bind(viewModel: homeViewModel)
        
        //        let home = homeView
        
        
        
        let search = UINavigationController(rootViewController: searchView)
        
        //        let search = searchView
        
        
        
        let star = UINavigationController(rootViewController: starView)
        
        //        let star = starView
        
        
        
        let my = UINavigationController(rootViewController: myView)
        
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
        guard let nav = viewController as? UINavigationController else { return false }
        guard let controller  = nav.viewControllers.first else { return false}

        switch controller.self {
//            case is HomeViewController:
//                Log.info("HomeViewController")
//                let homeViewModel = HomeViewModel(title: "Main", service: service )
//                homeView.bind(viewModel: homeViewModel)
//                break;
            case is  SearchViewController:
                Log.info("SearchViewController")
                if  searchView.viewModel == nil{
                    let searchViewModel = SearchViewModel(title: "Search", service: service)
                    searchView.bind(viewModel: searchViewModel)
                }
                break;
            case is  StarViewController:
                Log.info("StarViewController")
                if  starView.viewModel == nil{
                    let starViewModel = StarViewModel(title: "Star", service: service)
                    starView.bind(viewModel: starViewModel)
                }
                break;
            case is   MyViewController:
                Log.info("MyViewController")
                if  myView.viewModel == nil{
                    let myViewModel = MyViewModel(title: "My", service: service)
                    myView.bind(viewModel: myViewModel)
                }
                break;
            default:
                break
        }
        
        
        return true;
    }
}
