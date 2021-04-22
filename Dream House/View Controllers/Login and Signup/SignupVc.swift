//
//  SignupVc.swift
//  Dream House
//
//

import UIKit
import SVProgressHUD
import FirebaseAuth
import Firebase

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
            self.signUp()
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
    
    func signUp(){
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!, completion: {
            user, error  in
            if error != nil {
                print (error!)
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                SVProgressHUD.dismiss()
            }
            else {
                
                self.uploadData()

                
            }
        }
        )
    }
    
    func uploadData(){
            self.uploadImage(self.userProfileImage.image!){ url in
                self.saveImage(profileUrl: url!){ sucess in
                    if sucess != nil {
                        print ("ohhhh yeaaah")
                    }
                }
                
            }
        }
        
        
    func uploadImage(_ image:UIImage, completion: @escaping ((_ url: URL?) ->())){
            let imageName = NSUUID().uuidString
            let uid = Auth.auth().currentUser?.uid
            let storageRef = Storage.storage().reference().child("ProfilePic").child("\(uid!)").child("\(imageName)")
            let imgData = userProfileImage.image?.pngData()
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
                if error == nil {
                    print("sucess")
                    storageRef.downloadURL(completion: { (url, error) in
                        completion(url)
                    })
                } else {
                    print("error in saving image to firebase")
                    completion(nil)
                }
            }
        }
    
    func saveImage(profileUrl: URL, completion: @escaping ((_ url: URL?) ->())){
        let dict = ["username": usernameTF.text!, "Email": emailTF.text!, "Type": self.type,"ProfilePic": profileUrl.absoluteString] as [String: Any]
        let ued = Auth.auth().currentUser?.uid
        let userRef = Database.database().reference().child("Users").child(ued!)
        userRef.updateChildValues(dict, withCompletionBlock: { (err, ref) in
            if err != nil{
                SVProgressHUD.dismiss()
                print(err!)
                return
            }
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Signup Complete", message: "Yeah!, \n Now You can login with this email and password for continue", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Login", style: .default, handler: {(UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            )
            alert.addAction(restartAction)
            self.present(alert, animated: true, completion: nil)
            print("Registration Sucessfull")
            print("User saved in firebase")
        })
    }
        

}
