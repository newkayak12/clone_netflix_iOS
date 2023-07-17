//
//  Step1ViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit


class Step1ViewController: BaseViewController, ViewModelBindable {
    var viewModel: Step1ViewModel!
    lazy var idInput: IdInput = {
        let input = IdInput(frame: .zero)
        return input
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
      
        let backButton = UIButton(frame: .zero)
        backButton.addTarget(self, action: #selector(fnBackBtn), for: .touchUpInside)
        backButton.tintColor = .white
        backButton.setImage(UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: CGFloat(18), weight: .bold)), for: .normal)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton)]
        
        let nextButton = UIButton(frame: .zero)
        nextButton.setTitle("다음", for: .normal)
        nextButton.addTarget(self, action: #selector(fnNextBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: nextButton)]
    }
    
    func setContstraints () {
        idInput.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.centerY)
            make.width.equalTo(view)
        }
    }
    
    func wireViewModel() {
        idInput.addInputEvent()
               .withUnretained(self)
               .bind{
                   if let text = $1 {
                       $0.viewModel.id = text
                   }
               }.disposed(by: rx.disposeBag)
    }
    
    func prepareUI() {
        view.addSubview(idInput)
        self.setContstraints()
    }
    
    @objc
    func fnBackBtn() {
        dismiss(animated: true)
    }
    @objc
    func fnNextBtn() {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$"
        

        idInput.invalid(text: "")
        if viewModel.id.isEmpty {
            idInput.invalid(text: "아이디가 비어있습니다.")
        } else if (viewModel.id.range(of: emailRegex, options: .regularExpression) == nil) {
            idInput.invalid(text: "아이디가 이메일 형식이 아닙니다.")
        } else {
            var signInStep2ViewContorller = Step2ViewController()
            let signInStep2ViewModel = Step2ViewModel(title: "", service: viewModel.service)
            signInStep2ViewModel.id = self.viewModel.id
            signInStep2ViewContorller.bind(viewModel: signInStep2ViewModel)
            
            navigationController?.pushViewController(signInStep2ViewContorller, animated: false)
        }
    }
        
      
   
}
