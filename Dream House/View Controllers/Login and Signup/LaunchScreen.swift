//
//  LaunchScreen.swift
//  Dream House
//
//

import UIKit

class LaunchScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.pushVc(storyboardId: "WelcomeVc")
        }
    }
    

}
