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
        btn.setTitle("시청하기", for: .normal)
        btn.titleLabel?.backgroundColor = .systemPink
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.clipsToBounds = true
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.layer.cornerRadius = 10
        
        return btn
    }()
    
    lazy var descriptionLabel = {
        let label = UILabel(frame: .zero)
        label.text = "\ndesc \n desc \n desc"
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        
        
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
        stackView.spacing = 15
        stackView.alignment = .center
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
        return collectionView
    }()
    
    lazy var reviewTableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.cellId)
        return tableView
    }()
    
    lazy var contentsView = {
        let stack = UIStackView(arrangedSubviews: [self.personCollectionView, self.reviewTableView])
        stack.axis = .vertical
        
        return stack
    }()
    
    
    lazy var contentsDetailTable = {
        
    }()
    
    
    lazy var scrollView = {
        let view = UIScrollView(frame: .zero)
        view.addSubview(self.infoStackView)
//        view.addSubview(self.contentsView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        
        self.navigationItem.rightBarButtonItems = [share, bell]
        
        
        let backButton = UIButton(frame: .zero)
        backButton.addTarget(self, action: #selector(fnBackBtn), for: .touchUpInside)
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(18), weight: .bold)), for: .normal)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton)]
    }
    
    func wirePersonCollection () {
        self.viewModel.personSubject.bind(to: self.personCollectionView.rx.items(cellIdentifier: PersonCollectionViewCell.cellId, cellType: PersonCollectionViewCell.self )) {
            (row, element, cell) in
            
            cell.title.text = "TEXT"
            cell.subTitle.text = "SUBTITLE"
            Log.debug("PERSONCOLLECTION")
            
        }.disposed(by: rx.disposeBag)
    }
    
    func wireReviewTable () {
        self.viewModel.reviewSubject.bind(to: self.reviewTableView.rx.items(cellIdentifier: ReviewTableViewCell.cellId, cellType:ReviewTableViewCell.self)) {
            (row, element, cell) in
            Log.debug("REVIEWTALBE")
        }.disposed(by: rx.disposeBag)
    }
    
    func wireViewModel() {
        self.wirePersonCollection()
        self.wireReviewTable()
        
        self.viewModel.segmentIndex
            .subscribe{
                if let idx = $0.element {
                    Log.debug(">>>>>>", idx)
                if idx == 0 {
                    Log.debug("SEGMENT", 0)
                    self.viewModel.fetchPerson()
                    self.viewModel.fetchReview()
                } else if idx == 1 {
                    Log.debug("SEGMENT", 1)
                    self.viewModel.fetchContentsDetail()
                }
            }
        }.disposed(by: rx.disposeBag)
        
        self.segment.selectedSegmentIndex = 0
        self.viewModel.segmentIndex.onNext(0)
    }
    
    func setConstraints() {
        self.infoStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.scrollView)
        }
        
        self.posterImage.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(250)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.width.equalTo(view).offset(-15)
        }
        
        self.subtitleLabel.snp.makeConstraints { make in
            make.width.equalTo(view).offset(-15)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(view).offset(-15)
        }
        
        self.segment.snp.makeConstraints { make in
            make.width.equalTo(self.scrollView)
        }
        
        self.watchBtn.snp.makeConstraints { make in
            make.width.equalTo( self.infoStackView ).multipliedBy( 0.9 )
            make.height.equalTo(50)
            make.centerX.equalTo(self.scrollView)
        }
        
        self.watchBtn.titleLabel!.snp.makeConstraints{ make in
            make.width.equalTo(self.watchBtn)
            make.height.equalTo(50)
        }
//        
//        self.contentsView.snp.makeConstraints { make in
//            make.top.equalTo(self.infoStackView.snp.bottom).offset(15)
//            make.leading.trailing.equalTo(self.scrollView)
//        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        
     
    }
    
    func prepareUI() {
        view.addSubview(self.scrollView)
        
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
