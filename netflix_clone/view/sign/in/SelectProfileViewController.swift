//
//  SelectProfileViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/15.
//

import UIKit

class SelectProfileViewController: BaseViewController, ViewModelBindable  {
    var viewModel: SelectProfileViewModel!
    var resultStackView: UIStackView = UIStackView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    func setNavigation() {
        
    }
    
    func wireViewModel() {
        
    }
    
    func setConstraints () {
        self.resultStackView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    func prepareUI() {
        self.viewModel.fetchProfile(accountNo: 0)
        
        self.viewModel.profileSubject.map {
            return $0.enumerated().map {
                Log.info("MAP", $0)
                Log.info("MAP", $1)
                
                let img = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current), scale: .large)))
                img.clipsToBounds = true
                img.layer.cornerRadius = 50
                img.snp.makeConstraints { make in
                    make.width.equalTo(100)
                    make.height.equalTo(100)
                }
//
                let label = UILabel(frame: .zero)
                label.font = UIFont.boldSystemFont(ofSize: 20)
                label.text = "TEXT"
                label.textAlignment = .center
                label.textColor = .white

                let stack = UIStackView(arrangedSubviews: [img, label])
                stack.axis = .vertical
                stack.spacing = 10
                let gesture = ProfileGesture(target: self, action: #selector(self.selectProfile(sender:)))
                gesture.index = $0
                stack.addGestureRecognizer(gesture)
                return stack
            }
        }.subscribe { result  in
            
            self.resultStackView = UIStackView(arrangedSubviews: result)
            self.resultStackView.axis = .horizontal
            self.resultStackView.spacing = 10
        
        }.disposed(by: rx.disposeBag)
        
        view.addSubview(self.resultStackView)
        
        self.setConstraints()
    }
    
    @objc func selectProfile(sender: ProfileGesture) {
        if let index = sender.index {
            
        }
        
        
    }
    
    
    
}
