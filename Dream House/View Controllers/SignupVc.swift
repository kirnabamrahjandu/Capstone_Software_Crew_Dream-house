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
      
        let addImageGesture = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        self.userProfileImage.addGestureRecognizer(addImageGesture)
        self.userProfileImage.isUserInteractionEnabled = true
        imagePicker.delegate = self
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.height / 2
       
    }
    

    @IBAction func signupAction(_ sender: Any) {

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
