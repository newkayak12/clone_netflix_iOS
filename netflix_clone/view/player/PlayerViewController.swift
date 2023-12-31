//
//  PlayerViewController.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/29.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: AVPlayerViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.shouldSupportAllOrientation = false
        
        if #available(iOS 16.0, *) {
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
        } else {
            let value = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            Log.debug("16 lower")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Log.warning("viewWillDisappear _ ROTATION!")
        
        
        if #available(iOS 16.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
        } else {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.shouldSupportAllOrientation = false
        super.viewWillDisappear(animated)
    }
}


