//
//  BaseViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/06/27.
//

import UIKit
import SwiftUI
import RxCocoa

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.warning("viewDidLoad")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Log.warning("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Log.warning("viewDidAppear")
    }
   
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Log.warning("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Log.warning("viewDidDisappear")
    }
   
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Log.warning("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Log.warning("viewDidLayoutSubviews")
    }
   
    
}


