//
//  LoginVc.swift
//  Dream House
//
//  Created by DreamHouseTeam Kumar on 07/04/21.
//

import UIKit


class LoginVc: UIViewController {

    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var forgotPasswordBtn: UIButton!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signupBtn: UIButton!
    @IBOutlet var googleLoginBtn: UIButton!
    
    var userType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        self.googleLoginBtn.layer.cornerRadius = 40
    
    }
    
    @IBAction func loginBrnAction(_ sender: Any) {
       
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVc") as! SignupVc
        vc.type = self.userType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func googleLoginAction(_ sender: Any) {
     
    }

    }

