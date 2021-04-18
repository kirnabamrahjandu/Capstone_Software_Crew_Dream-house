//
//  LoginVc.swift
//  Dream House
//
//  Created by Prince Kumar on 07/04/21.
//

import UIKit
import GoogleSignIn
import Firebase
import SVProgressHUD


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
        self.loginBtn.setCornerRadius()
        self.emailTF.text = "abc@gmail.com"
        self.passwordTF.text = "123456"
        self.googleLoginBtn.layer.cornerRadius = 40
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    @IBAction func loginBrnAction(_ sender: Any) {
        self.loginAction()
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
        self.pushVc(storyboardId: "MainTabBarVc")
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
    
    func loginAction(){
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!, completion: {
               (user, error) in
            if Auth.auth().currentUser != nil {
                
                email = Auth.auth().currentUser?.email ?? ""
                self.logbye()
               }
                   else{
                       SVProgressHUD.dismiss()
                    self.showAlert(title: "ERROR", message: error!.localizedDescription)
                   }
                   
                   
           }
       ) }
    
    
    func logbye(){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictonary = snapshot.value as? [String: AnyObject]{
                print(dictonary, "firebase data")
                userProfileURL = dictonary["ProfilePic"] as! String
                username = dictonary["username"] as! String
                SVProgressHUD.dismiss()
                self.pushVc(storyboardId: "MainTabBarVc")
            }
        } ,withCancel: nil)
        
        
    }
    }

