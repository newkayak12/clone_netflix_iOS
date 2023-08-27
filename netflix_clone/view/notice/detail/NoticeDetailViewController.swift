//
//  NoticeDetailViewContorller.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/27.
//

import RxCocoa
import UIKit

class NoticeDetailViewController: BaseViewController, ViewModelBindable  {
    var viewModel: NoticeDetailViewModel!
    
    
    
    func setNavigation() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let backButton = UIButton(frame: .zero)
        backButton.addTarget(self, action: #selector(fnBackBtn), for: .touchUpInside)
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(18), weight: .bold)), for: .normal)
        let label = UILabel(frame: .zero)
        label.text = self.viewModel.title
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton), UIBarButtonItem(customView: label)]
        
        
        
    }
    
    func wireViewModel() {
    }
    
    func prepareUI() {
        
        if let date = self.viewModel.notice?.regDate {
            let dateLabel = UILabel(frame: .zero)
            dateLabel.textAlignment = .left
            dateLabel.font = UIFont.systemFont(ofSize: 10)
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
            dateLabel.text = dateFormat.string(from: date)
        }
    }
    
    @objc
    func fnBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
  
    
    
}
