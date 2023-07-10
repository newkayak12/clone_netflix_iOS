//
//  NoticeViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/09.
//

import Foundation
import SwiftUI
import RxSwift
import Lottie

class NoticeViewController: BaseViewController, ViewModelBindable {
    var viewModel: NoticeViewModel!
    private lazy var animationView = {
        let uiView = UIView(frame: .zero)
        let animationView =  LottieAnimationView(name: "spinner")
//        let animationView =  UIImageView(image: UIImage(systemName: "tray.circle.fill"))
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.loopMode = .loop
        animationView.play()
        
        
        uiView.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.center.equalTo(uiView)
        }
        
        return uiView
    }()
    private lazy var noticeTableView = {
        let tableView = UITableView();
        
        return tableView;
    }()
    
    func setNavigation() {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text = viewModel.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        let title = UIBarButtonItem(customView: titleLabel)
        
        let closeImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body), scale: .large))
        let xButton = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(fnRouteClose))
        xButton.tintColor = .white
        navigationItem.leftBarButtonItems  = [
            xButton,
            title
        ]
    }
    
    func wireNotice() {
        viewModel.loading
        .withUnretained(self)
        .subscribe{
            this, value in
            Log.warning("LOTTIE", !value)
            this.animationView.isHidden = !value
        }.disposed(by: rx.disposeBag)
        
        self.noticeTableView.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.cellId)
        viewModel.notice.bind(to: noticeTableView.rx.items(cellIdentifier: NoticeCell.cellId)){ (row, element, cell) in
            Log.warning("NOTICE", "..")
        }.disposed(by: rx.disposeBag)
        
        
        Observable.zip(noticeTableView.rx.modelSelected(Notice.self), noticeTableView.rx.itemSelected)
                  .withUnretained(self)
                  .do { this, data in
//                      this.noticeTableView.deselectRow(at: data.1, animated: true)
                  }
                  .map{ $0.1 }
                  .withUnretained(self)
                  .subscribe{ this, data in
                      print(data.0)
                      print(data.1)
                  }.disposed(by: rx.disposeBag)
    }
    
    func wireViewModel() {
        self.wireNotice()
        
        viewModel.fetchNotice()
        self.noticeTableView.reloadData()
    }
   
    func setAttributes () {
        self.noticeTableView.backgroundColor = .clear
    }
    
    func setConstraints () {
        noticeTableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view)
        }
        animationView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(100)
        }
    }
    
    func prepareUI() {
        view.addSubview(self.noticeTableView)
        view.addSubview(self.animationView)
        view.bringSubviewToFront(self.animationView)
        
        
        self.setConstraints()
        self.setAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    
    
    @objc
    func fnRouteClose() {
        dismiss(animated: true)
    }
    
}



#if DEBUG
@available(iOS 13, *)
struct NoticePreview: PreviewProvider {
    
    
    static var previews: some View {
        // view controller using programmatic UI
        NoticeViewController().toPreview()
    }
}
#endif
