//
//  Step2ViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/14.
//

import Foundation
import UIKit
import SwiftUI
import RxSwift

class Step2ViewController: BaseViewController, ViewModelBindable {
    lazy var passwordInput: PasswordInput = {
        let input = PasswordInput(frame: .zero)
        return input
    }()
    lazy var findPassword: UIButton = {
        let findPwdButton = UIButton(frame: .zero)
        findPwdButton.setTitle("비밀번호를 잃어버리셨나요?", for: .normal)
        findPwdButton.tintColor = .lightGray
        findPwdButton.addTarget(self, action: #selector(self.findPwd), for: .touchUpInside)
        return findPwdButton
    }()
    
    var viewModel: Step2ViewModel!
    
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
    
    func setConstraints () {
        
        passwordInput.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.centerY)
            make.width.equalTo(view)
        }
        
        findPassword.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func wireViewModel() {
        passwordInput.addInputEvent()
            .withUnretained(self)
            .bind{
                if let text = $1 {
                    $0.viewModel.password = text
                }
            }.disposed(by: rx.disposeBag)
        
    }
    
    func prepareUI() {
        view.addSubview(passwordInput)
        view.addSubview(findPassword)
        
        
        self.setConstraints()
    }
    
    @objc
    func fnBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    @objc
    func fnNextBtn() {
    }
    
    @objc
    func findPwd() {
        
    }
    
    @objc
    func onKeyboardUp (_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            findPassword.snp.removeConstraints()
            findPassword.snp.makeConstraints { make in
                make.leading.equalTo(view).offset(20)
                make.bottom.equalTo(view).offset(-keyboardHeight)
            }
        }
        
    }
    @objc
    func onKeyboardDown (_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            findPassword.snp.removeConstraints()
            findPassword.snp.makeConstraints { make in
                make.leading.equalTo(view).offset(20)
                make.bottom.equalTo(view.layoutMarginsGuide)
            }
        }
    }
}
