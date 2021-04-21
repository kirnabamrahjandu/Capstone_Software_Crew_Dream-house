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
        menuIcon()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "My Profile"
    }


    func menuIcon(){
        
        let dp = userProfileURL
        let postedImage = dp
        let url = URL(string: postedImage)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.addProfileImage.image = UIImage(data: data!)
            }
        }).resume()
        
        
        let navBarPlusButton = UIBarButtonItem(image: UIImage(named:  "menu"),  style: .plain, target: self, action: #selector(tabNavigations))
        navigationItem.leftBarButtonItem = navBarPlusButton
    }
    
    @objc func tabNavigations(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuVc") as! MenuVc
        vc.ref = self
        self.transitionVc(vc: vc, duration: 0.1, type: .fromLeft)
    }

}
