//
//  DetailViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/02.
//

import UIKit
import RxCocoa

class DetailViewController: BaseViewController, ViewModelBindable {
    var viewModel: DetailViewModel!
    
    lazy var posterImage = {
        let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var titleLabel = {
        let label = UILabel(frame: .zero)
        label.text = "TITLE"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    lazy var subtitleLabel = {
        let label = UILabel(frame: .zero)
        label.text = "SUBTITLE"
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
    
    lazy var segment = {
        let seg = UISegmentedControl(frame: .zero)
        seg.insertSegment(withTitle: "콘텐츠 정보", at: 0, animated: true)
        seg.insertSegment(withTitle: "회차 정보", at: 1, animated: true)
        
        seg.rx.selectedSegmentIndex
        .withUnretained(self)
        .subscribe{
            $0.viewModel.segmentIndex.onNext($1)
        }.disposed(by: rx.disposeBag)
        
        return seg
    }()
    
    lazy var infoStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.posterImage, self.titleLabel, self.subtitleLabel, self.watchBtn, self.descriptionLabel, self.segment])
        stackView.axis = .vertical
        return stackView
    }()
    
    
    
    
    lazy var personCollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        let size = (view.frame.width - 20)
        flowLayout.itemSize.width = size
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.cellId)
        
        self.viewModel.personSubject.bind(to: collectionView.rx.items(cellIdentifier: PersonCollectionViewCell.cellId, cellType: PersonCollectionViewCell.self )) {
            (row, element, cell) in
            
            cell.title.text = "TEXT"
            cell.subTitle.text = "SUBTITLE"
            
            
        }.disposed(by: rx.disposeBag)
        
        return collectionView
    }()
    
    lazy var reviewTableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.cellId)
        self.viewModel.reviewSubject.bind(to: tableView.rx.items(cellIdentifier: ReviewTableViewCell.cellId, cellType:ReviewTableViewCell.self)) {
            (row, element, cell) in
        }.disposed(by: rx.disposeBag)
        
        
        return tableView
    }()
    
    lazy var contentsView = {
        let stack = UIStackView(arrangedSubviews: [self.personCollectionView, self.reviewTableView])
        stack.axis = .vertical
        
        return stack
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
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItems = [share, bell]
        
        
        let backButton = UIButton(frame: .zero)
        backButton.addTarget(self, action: #selector(fnBackBtn), for: .touchUpInside)
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(18), weight: .bold)), for: .normal)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton)]
    }
    
    func wireViewModel() {
        self.segment.selectedSegmentIndex = 0
    }
    
    func setConstraints() {
        self.infoStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(view.layoutMarginsGuide)
        }
        self.posterImage.snp.makeConstraints { make in
            make.height.equalTo(self.view.frame.width / 3)
        }
    }
    
    func prepareUI() {
        view.addSubview(self.infoStackView)
        
        self.setConstraints()
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
