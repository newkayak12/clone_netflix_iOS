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
    var signView = Step1ViewController()
    
    
   
    
    func setLaunchScreen () {
        view.addSubview(launchScreen)
        
        // 2
        launchScreen.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        launchScreen.alpha = 1
        tabBar.isHidden = true
        // 3
        launchScreen.play { [unowned self] _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.launchScreen.alpha = 0
            }, completion: { _ in
                self.launchScreen.isHidden = true
                self.launchScreen.removeFromSuperview()
                
                
//                UserDefaults.standard.setValue("KEY", forKey: Constants.TOKEN.rawValue)
                
                
                if UserDefaults.standard.string(forKey: Constants.TOKEN.rawValue) == nil {
                    if self.signView.viewModel == nil {
                        let signInStep1ViewModel = Step1ViewModel(title: "", service: self.service)
                        signInStep1ViewModel.isBack = false
                        self.signView.bind(viewModel: signInStep1ViewModel)
                    }
                    self.view.window?.rootViewController = UINavigationController(rootViewController: self.signView)
                } else {
                    self.initializeView()
                    self.tabBar.isHidden = false
                }
                
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
        
       
        if homeView.viewModel == nil {
            let homeViewModel = HomeViewModel(title: "Main", service: service )
            homeView.bind(viewModel: homeViewModel)
        }
        
        let home = UINavigationController(rootViewController: homeView)
        let search = UINavigationController(rootViewController: searchView)
        let star = UINavigationController(rootViewController: starView)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = UserDefaults.standard.string(forKey: Constants.TOKEN.rawValue) {
            self.initializeView()
            self.tabBar.isHidden = false
        } else {
            self.setLaunchScreen()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func whenNotSigned(viewController: UINavigationController) -> UINavigationController {
        if UserDefaults.standard.string(forKey: Constants.TOKEN.rawValue) == nil {
            if signView.viewModel == nil {
                let signInStep1ViewModel = Step1ViewModel(title: "", service: service)
                signView.bind(viewModel: signInStep1ViewModel)
            }
            return UINavigationController(rootViewController: signView)
        } else {
            return viewController
        }
    }
}

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let nav = viewController as? UINavigationController else { return false }
        guard let controller  = nav.viewControllers.first else { return false}
        
        self.whenSigned(controller: controller, viewController: viewController)
        return true;
    }
    
   
    
    func whenSigned( controller: UIViewController,  viewController: UIViewController) {
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
                if signView.viewModel == nil {
                    let signInStep1ViewModel = Step1ViewModel(title: "", service: service)
                    signView.bind(viewModel: signInStep1ViewModel)
                }
                break
        }
    }
}
