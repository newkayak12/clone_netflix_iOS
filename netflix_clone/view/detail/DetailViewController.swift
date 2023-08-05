//
//  DetailViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/02.
//

import Foundation
import UIKit

class DetailViewController: BaseViewController, ViewModelBindable {
    var viewModel: DetailViewModel!
    
    lazy var posterImage = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        return img
    }()
    
    lazy var titleLabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    lazy var subtitleLabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var watchBtn = {
        let btn = UIButton(frame: .zero)
        btn.tintColor = .systemPink
        btn.titleLabel?.text = "시청하기"
        btn.titleLabel?.textColor = .white
        return btn
    }()
    
    lazy var descriptionLabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22)
        
        return label
    }()
    
    lazy var infoStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.posterImage, self.titleLabel, self.subtitleLabel, self.watchBtn, self.descriptionLabel])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    
    lazy var segment = {
        
    }()
    
    
    lazy var personCollectionView = {
        
    }()
    
    lazy var reviewTableView = {
        
    }()
    
    lazy var contentsView = {
        
    }()
    
    
    lazy var contentsDetailTable = {
        
    }()
    
    lazy var contentsDetailView = {
        
    }()
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = .black
    }
    
    
    
    func setNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let symbolConf = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)
        let bellImg = UIImage(systemName: "bell", withConfiguration: symbolConf)
        let bell = UIBarButtonItem(image: bellImg, style: .plain, target: self, action: #selector(fnRouteNotice ))
        let shareImg = UIImage(systemName: "ellipsis", withConfiguration: symbolConf)
        let share = UIBarButtonItem(image:  shareImg, style: .plain, target: self, action: #selector(fnShare))
        share.tintColor = .white
        bell.tintColor = .white
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItems = [share, bell]
        
        
        let backButton = UIButton(frame: .zero)
        backButton.addTarget(self, action: #selector(fnBackBtn), for: .touchUpInside)
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(18), weight: .bold)), for: .normal)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton)]
    }
    
    func wireViewModel() {
    }
    
    func prepareUI() {
    }
    
    
    @objc
    private func fnShare () {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let share = UIAlertAction(title: "공유", style: .default) { action in
            action.isEnabled.toggle()
        }
        let like = UIAlertAction(title: "좋아요", style: .default) { action in
            action.isEnabled.toggle()
        }
        alert.addAction(share)
        alert.addAction(like)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
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
    func fnBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
