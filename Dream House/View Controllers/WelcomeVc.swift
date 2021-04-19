//
//  WelcomeVc.swift
//  Dream House
//
//

import UIKit

class WelcomeVc: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet var HouseProviderBtn: UIButton!
    @IBOutlet var userBtn: UIButton!
    
    //MARK:- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:- IBACTIONS
    @IBAction func houseRoomProviderAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVc") as! LoginVc
        vc.userType = "provider"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func userAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVc") as! LoginVc
        vc.userType = "user"
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
