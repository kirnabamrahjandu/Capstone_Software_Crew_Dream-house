//
//  SignupVc.swift
//  Dream House
//
//  Created by Prince Kumar on 07/04/21.
//

import UIKit


class SignupVc: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var userProfileImage: UIImageView!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var signupAction: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var type = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signupAction.setCornerRadius()
        let addImageGesture = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        self.userProfileImage.addGestureRecognizer(addImageGesture)
        self.userProfileImage.isUserInteractionEnabled = true
        imagePicker.delegate = self
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.height / 2
        self.signupAction.setCornerRadius()
    }
    

    @IBAction func signupAction(_ sender: Any) {
        if self.usernameTF.text?.replacingOccurrences(of: " ", with: "") == ""{
            self.showAlert(title: "Please Check", message: "User cannot be blank")
            return
        }
        
       else if self.emailTF.text?.replacingOccurrences(of: " ", with: "") == ""{
            self.showAlert(title: "Please Check", message: "Email cannot be blank")
        return
        }
        else if self.passwordTF.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.showAlert(title: "Please Check", message: "Password cannot be blank")
            return
        }
        else if passwordTF.text?.count ?? 0 < 6 {
            self.showAlert(title: "Please Check", message: "Password must have minimum 6 characters")
            return
        }
        else{
           
        }
    }
    
    
    @objc func openGallery(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
           
           self.userProfileImage.image = image
           
           dismiss(animated: true, completion: nil)
    }
    
    
}
