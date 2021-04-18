//
//  WelcomeVc.swift
//  Dream House
//
//  Created by Prince Kumar on 07/04/21.
//

import UIKit

class WelcomeVc: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet var HouseProviderBtn: UIButton!
    @IBOutlet var userBtn: UIButton!
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HouseProviderBtn.setCornerRadius()
        self.userBtn.setCornerRadius()
    }
    
    //MARK:- IBACTIONS
    @IBAction func houseRoomProviderAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVc") as! LoginVc
        vc.userType = "provider"
        userType = "provider"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func userAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVc") as! LoginVc
        vc.userType = "user"
        userType = "user"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
