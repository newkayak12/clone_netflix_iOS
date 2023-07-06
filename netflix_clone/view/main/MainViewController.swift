//
//  MainViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/01.
//

import UIKit
import SwiftUI
import SnapKit

class MainViewController: BaseViewController, ViewModelBindable {
    
    
    func wireViewModel() {
        
        
    }
    
    func prepareUI() {
        
        let redView = UIView(frame: .zero)
        let blueView = UIView(frame: .zero)
        let yellowView = UIView(frame: .zero)
        
        redView.backgroundColor = .red
        blueView.backgroundColor = .blue
        yellowView.backgroundColor = .yellow
        
        
        view.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(yellowView)
        
        redView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.5)
            make.width.height.equalTo(50)
        }
        blueView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.height.equalTo(50)
        }
        yellowView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.5)
            make.width.height.equalTo(50)
        }
        
    }
    
    var viewModel: MainViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        prepareUI()
        #endif
    }


}
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct Preview: PreviewProvider {

    static var previews: some View {
        // view controller using programmatic UI
        MainViewController().toPreview()
    }
}
#endif
