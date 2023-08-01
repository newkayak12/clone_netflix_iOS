//
//  StarViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/07.
//

import Foundation
import UIKit
import SwiftUI
import RxSwift

class StarViewController: BaseViewController, ViewModelBindable {
    var viewModel: StarViewModel!
    
    var  fullCount: Float = 30.0
    var now = BehaviorSubject<Float>(value: 1.0)
    
    lazy var score = {
       return  now.map { value in
            return  (value / self.fullCount)
        }
    }()
    
    lazy var label = {
        let view = UILabel(frame: .zero)
        view.text = "한 번 마음먹으면 하는 분이시네요"
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return view
    }()
    lazy var count = {
        let view = UILabel(frame: .zero)
        view.text = "0"
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.textAlignment = .center
        view.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        return view
    }()
    lazy var percentageBar = {
        let bar = UIProgressView(progressViewStyle: .bar)
        self.score.bind(to: bar.rx.progress).disposed(by: rx.disposeBag)
        bar.tintColor = .systemPink
        
        return bar
    }()
    lazy var headerView = {
        let view = UIStackView(arrangedSubviews: [self.label, self.count, self.percentageBar ])
//        view.spacing = 10
        view.axis = .vertical
        return view
    }()
    lazy var ratingTable = {
        let table = UITableView(frame: .zero)
        table.register(RatingTableViewCell.self, forCellReuseIdentifier: RatingTableViewCell.cellId)
        self.viewModel.starPublish.bind(to: table.rx.items(cellIdentifier: RatingTableViewCell.cellId, cellType:RatingTableViewCell.self)) { (row, element, cell) in
            cell.delegate = self
        }.disposed(by: rx.disposeBag)
        table.rowHeight = 95
        table.rx.itemSelected
            .withUnretained(table)
            .bind { (this, index) in
                this.deselectRow(at: index, animated: true)
            }.disposed(by: rx.disposeBag)
        return table
    }()
    
    func setNavigation() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        
        
        
        let symbolConf = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        let bellImg = UIImage(systemName: "bell", withConfiguration: symbolConf)
        let profileImg = UIImage(systemName: "person.crop.circle", withConfiguration: symbolConf)
        let profile = UIBarButtonItem(image: profileImg, style: .plain, target: self, action: #selector(fnRouteProfile))
        let bell = UIBarButtonItem(image: bellImg, style: .plain, target: self, action: #selector(fnRouteNotice))
        
        profile.tintColor = .white
        bell.tintColor = .white
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItems = [ profile, bell]
        
        navigationItem.title = "평가"
        navigationItem.titleView = UILabel(frame: .zero)
    }
    
    func wireViewModel() {
        self.viewModel.fetchStar()
    }
    
    func setConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(100)
        }
        ratingTable.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func prepareUI() {
        view.addSubview(headerView)
        view.addSubview(ratingTable)
        
        
        
        self.setConstraints()
    }
    
    
    
    
    @objc
    private func fnRouteNotice () {
        let noticeViewModel = NoticeViewModel(title: "알림", service: self.viewModel.service)
        var noticeView = NoticeViewController()
        noticeView.bind(viewModel: noticeViewModel)
        let navtigation = UINavigationController(rootViewController: noticeView)
        navigationController?.present(navtigation, animated: true)
        navigationController?.modalPresentationStyle = .fullScreen
    }
    @objc
    func fnRouteProfile () {
        if let token = UserDefaults.standard.string(forKey: Constants.TOKEN.rawValue)  {
            Log.warning("TOKEN", token)
        } else {
            var signInStep1ViewController = Step1ViewController()
            let signInStep1ViewModel = Step1ViewModel(title: "", service: viewModel.service)
            signInStep1ViewController.bind(viewModel: signInStep1ViewModel)
            navigationController?.present(UINavigationController(rootViewController: signInStep1ViewController), animated: true)
            navigationController?.modalPresentationStyle = .fullScreen
        }
    }
}

extension StarViewController: StarRateDelegate {
    func rating(no: Int, value: Float) {
        Log.warning("RATING to \(no)" , value)
    }
}
