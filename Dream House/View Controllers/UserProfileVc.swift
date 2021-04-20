//
//  UserProfileVc.swift
//  Dream House
//
//

import UIKit
import Firebase

class UserProfileVc: UIViewController {

    @IBOutlet var addProfileImage: UIImageView!
    
    @IBOutlet var userNameTF: UITextField!
    
    @IBOutlet var userTypeTF: UITextField!
    
    @IBOutlet var eMailTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.eMailTF.text = Auth.auth().currentUser?.email
        self.userNameTF.text = username
        self.userTypeTF.text = userType
     
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "My Profile"
    }




}
