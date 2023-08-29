//
//  DetailViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/02.
//

import UIKit
import RxCocoa
import RxSwift
import AVKit
import AVFoundation


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
        
        btn.addTarget(self, action: #selector(fnStream), for: .touchUpInside)
        
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
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.posterImage,
            self.titleLabel,
            self.subtitleLabel,
            self.watchBtn,
            self.descriptionLabel,
            self.segment,
        ])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()
    
    
    
    
    lazy var personCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.headerReferenceSize = CGSize(width: 100, height: 100)
        let size = (view.frame.width - 20)
        flowLayout.itemSize.width = size
        flowLayout.itemSize.height = 60
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.cellId)
        collectionView.register(PersonCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PersonCollectionViewHeader.cellId)
        
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    lazy var personStackView = {
        let label = UILabel(frame: .zero)
        label.text = "감독/출연진"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        let stack = UIStackView(arrangedSubviews: [label, self.personCollectionView])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    lazy var reviewTableView: UITableView = {
        let tableView = ReviewTableView(frame: .zero)
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.cellId)
        tableView.isScrollEnabled = false
        tableView.rowHeight = 150
        tableView.isUserInteractionEnabled = false
        return tableView
    }()
    
    lazy var reviewStackView = {
        let label = UILabel(frame: .zero)
        label.text = "리뷰"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        let stack = UIStackView(arrangedSubviews: [label, self.reviewTableView])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    
    
    lazy var contentsDetailTable = {
        let tableView = ContentsTableView(frame: .zero)
        tableView.register(ContentsTableViewCell.self, forCellReuseIdentifier: ContentsTableViewCell.cellId)
        tableView.isScrollEnabled = false
        tableView.rowHeight = 100
        return tableView
    }()
    
    lazy var contentsStackView = {
        let label = UILabel(frame: .zero)
        label.text = "회차 정보"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        let stack = UIStackView(arrangedSubviews: [label, self.contentsDetailTable])
        stack.axis = .vertical
        return stack
    }()
    
    
    lazy var scrollStack = {
        let stack  = UIStackView(arrangedSubviews: [self.infoStackView,self.personStackView,self.reviewStackView, self.contentsStackView])
        stack.axis = .vertical
        stack.spacing = 30
        return stack
    }()
    
    
    lazy var scrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.addSubview(self.scrollStack)
        return scroll
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        Log.debug("WIRE_PERSON")

        self.viewModel.personSubject.map{
            return [PersonSection(type: "감독/출연", items: $0)]
        }
        .bind(to: self.personCollectionView.rx.items(dataSource: viewModel.personDataSource))
        .disposed(by: rx.disposeBag)
        

        
        self.personCollectionView.rx
            .itemSelected
            .withUnretained(self)
            .subscribe(onNext: {
                Log.warning("COLLECTION SELECTED", $1)
                $0.personCollectionView.deselectItem(at: $1, animated: true)
                
                var viewController = PersonViewController()
                viewController.bind(viewModel: PersonViewModel(title: "인물이름", service: self.viewModel.service))
                viewController.viewModel.fetchPersonContents()
                self.navigationController?.pushViewController(viewController, animated: true)
            }).disposed(by: rx.disposeBag)
    }
    
    func wireReviewTable () {
        Log.debug("WIRE_REVIEW")
        
        self.viewModel.reviewSubject.bind(to: self.reviewTableView.rx.items(cellIdentifier: ReviewTableViewCell.cellId, cellType:ReviewTableViewCell.self)) {
            (row, element, cell) in
            Log.debug("REVIEWTALBE")
        }.disposed(by: rx.disposeBag)
    }
    
    func wireContentsDetailTable () {
        self.viewModel.contentDetailSubject
            .map{ [ContentsDetailSection(type: "\($0.count)개", items: $0)] }
            .bind(to: self.contentsDetailTable.rx.items(dataSource: self.viewModel.contnentsDetailDataSource))
            .disposed(by: rx.disposeBag)
        
        
        self.contentsDetailTable.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: {
                $0.contentsDetailTable.deselectRow(at: $1, animated: true)
            })
            .disposed(by: rx.disposeBag)
    }
    
    func wireViewModel() {
       self.wirePersonCollection()
       self.wireReviewTable()
       self.wireContentsDetailTable()
        
        self.viewModel.segmentIndex
            .subscribe{
                self.personStackView.isHidden = true
                self.reviewStackView.isHidden = true
                self.contentsStackView.isHidden = true
                if let idx = $0.element {
                    Log.debug(">>>>>>", idx)
                if idx == 0 {
                    self.personStackView.isHidden = false
                    self.reviewStackView.isHidden = false
                    Log.debug("SEGMENT", 0)
                    self.viewModel.fetchPerson()
                    self.viewModel.fetchReview()
                } else if idx == 1 {
                    self.contentsStackView.isHidden = false
                    Log.debug("SEGMENT", 1)
                    self.viewModel.fetchContentsDetail()
                }
            }
        }
            .disposed(by: rx.disposeBag)

        self.segment.selectedSegmentIndex = 0
        self.viewModel.segmentIndex.onNext(0)
    }
  
    func setConstraints() {
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

        self.personStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.scrollStack)
            make.height.greaterThanOrEqualTo(300)
        }
        
        self.scrollStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self.scrollView)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
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
        navigationController?.pushViewController(noticeView, animated: true)
        //        navigationController?.modalPresentationStyle = .fullScreen
    }
  
   
    @objc
    func fnBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func fnStream(){
//        guard let urlData = NSURL(string: "http://192.168.0.11:8000/api/v1/contents/2/27") else { return }
        guard let urlData = NSURL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4") else { return }
        let playerController = PlayerViewController()
        let player = AVPlayer(url: urlData as URL)
        playerController.player = player
        

        self.present(playerController, animated: true) {
            playerController.player!.play()
        }
        
    }
    
    
}
