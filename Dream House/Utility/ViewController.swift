//
//  ViewController.swift
//  Dream House
//
//

import UIKit

extension UIViewController {

    func pushVc(storyboardId : String){
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: storyboardId))!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func transitionVc(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
        let customVcTransition = vc
        let transition = CATransition()
        vc.modalPresentationStyle = .overFullScreen
        transition.duration = duration
        transition.type = CATransitionType.fade
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(customVcTransition, animated: false, completion: nil)
    }
    

}


extension UIButton{
    
    func setCornerRadius(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}


@objc protocol hideTable {
    func hideTable(data : String)
    
    func sortListBy(key : String, value : String)
}

@objc protocol dismissView {
    func hideView()
}

var username = ""
var email = ""
var userProfileURL = ""
var fvtModel = [Rent]()
var fvtThumbnail = [String]()
var userType = ""

struct K {
    static let appName = "Dream House"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        static let receiver = "receiver"
    }
}

var editPostArray = [UIImage]()
