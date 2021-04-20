//
//  AdvHomeDetailVc.swift
//  Dream House
//
//

import UIKit
import MessageUI

class AdvHomeDetailVc: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var advHomeDetailCollectionView: UICollectionView!
    
    @IBOutlet var totalBedroomsTF: UITextField!
    
    @IBOutlet var totalFloorsTF: UITextField!
    
    @IBOutlet var rentPerMonth: UITextField!
    
    @IBOutlet var busStandLoc: UITextField!
    
    var totalBed = ""
    var totalFloors = ""
    var rent = ""
    var busStand = ""
    var imagesArray = [String]()
    var contactNum = ""
    var emailAdd = ""
    var uidR = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advHomeDetailCollectionView.delegate = self
        advHomeDetailCollectionView.dataSource = self
    }
    
    
    @IBAction func callAction(_ sender: Any) {
        callTapped()
    }
    
    @IBAction func emailAction(_ sender: Any) {
        sendEmail()
    }
    
    @IBAction func messageAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.hidesBottomBarWhenPushed = true
        vc.sendTo = emailAdd
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension AdvHomeDetailVc : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvHomeDetailCollectionCell", for: indexPath) as! AdvHomeDetailCollectionCell
        
        return cell
    }
    
    func callTapped() {
        guard let number = contactNum as? String ,
              let url = URL(string: "telprompt://\(number)") else{
            print("Number failed")
            return
        }
        UIApplication.shared.open(url)
    }
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([self.emailAdd])
            mail.setMessageBody("<p>Hey! I m interested in your add</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
}
