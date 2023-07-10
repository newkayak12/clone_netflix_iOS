//
//  NoticeViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/09.
//

import Foundation
import SwiftUI

class NoticeViewController: BaseViewController, ViewModelBindable {
    var viewModel: NoticeViewModel!
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
        Log.warning("WIRE", "WIRE")
        self.noticeTableView.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.cellId)
        viewModel.notice.bind(to: noticeTableView.rx.items(cellIdentifier: NoticeCell.cellId)){ (row, element, cell) in
            Log.warning("NOTICE", "..")
        }.disposed(by: rx.disposeBag)
    }
    
    func wireViewModel() {
        self.wireNotice()
        
        viewModel.fetchNotice()
    }
   
    func setAttributes () {
        self.noticeTableView.backgroundColor = .clear
    }
    
    func setConstraints () {
        noticeTableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view)
        }
    }
    
    func prepareUI() {
        view.addSubview(self.noticeTableView)
        
        
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
