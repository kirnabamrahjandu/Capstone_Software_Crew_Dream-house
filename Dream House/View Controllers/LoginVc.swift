//
//  LoginVc.swift
//  Dream House
//
//

import UIKit
import GoogleSignIn

class LoginVc: UIViewController, GIDSignInDelegate {

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
        GIDSignIn.sharedInstance()?.signIn()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          
          if error != nil{
              return
          }
          
          print("sucessfully signed in ")
        username = user.profile.name ?? ""
        email = user.profile.email ?? ""
        userProfileURL = String(describing: user.profile.imageURL(withDimension: 200*200) as URL)
      //  self.pushVc(storyboardId: "MainTabBarVc")
          print(user.userID ?? 0 , user.profile.name ?? "", user.profile.email ?? "", user.profile.imageURL(withDimension: 200*200) as URL)
          
//          gmailId = user.userID ?? ""
//          first_name = user.profile.givenName ?? ""
//          last_name = user.profile.familyName ?? ""
//          gmailAddress = user.profile.email ?? ""
//          gmailProfileImg = String(describing: user.profile.imageURL(withDimension: 200*200) as URL)
//          googleLogin()
          if user == nil {
              return
          }
      }
    
    }

