//
//  AdvHomeDetailVc.swift
//  Dream House
//
//

import UIKit
import MessageUI
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class AdvHomeDetailVc: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var advHomeDetailCollectionView: UICollectionView!
    
    @IBOutlet var totalBedroomsTF: UITextField!
    
    @IBOutlet var totalFloorsTF: UITextField!
    
    @IBOutlet var rentPerMonth: UITextField!
    
    @IBOutlet var busStandLoc: UITextField!
    
    @IBOutlet var editBtn: UIButton!
    
    @IBOutlet var deleteBtn: UIButton!
    
    @IBOutlet var messageBtn: UIButton!
    
    @IBOutlet var playBtn: UIButton!
    
    @IBOutlet var videoView: AvpVideoPlayer!
    
    var totalBed = ""
    var totalFloors = ""
    var rent = ""
    var busStand = ""
    var imagesArray = [String]()
    var contactNum = ""
    var emailAdd = ""
    var uidR = ""
    var locationArea = ""
    var addType = ""
    var houseNo = ""
    var refImgArray = [UIImage]()
    var username = ""
    var videoURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalBedroomsTF.text = totalBed
        self.totalFloorsTF.text = totalFloors
        self.rentPerMonth.text = rent
        self.busStandLoc.text = busStand
        self.videoView.configure(url: videoURL)
        advHomeDetailCollectionView.delegate = self
        advHomeDetailCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.playBtn.setImage(UIImage(named: "play"), for: .normal)
        if userType == "user"{
            self.editBtn.isHidden = true
            self.deleteBtn.isHidden = true
        }
        else{
            if Auth.auth().currentUser?.email == self.emailAdd{
                self.editBtn.isHidden = false
                self.deleteBtn.isHidden = false
                self.messageBtn.isHidden = true
            }
            else{
                self.editBtn.isHidden = true
                self.deleteBtn.isHidden = true
                self.messageBtn.isHidden = false
            }
        }
        

    }
    
    @IBAction func deleteAction(_ sender: Any) {
        Database.database().reference().child("Rent").child(self.uidR).removeValue()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func callAction(_ sender: Any) {
        self.callTapped()
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
    
    
    @IBAction func editAction(_ sender: Any) {
        SVProgressHUD.show()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddHouseRoomVc") as! AddHouseRoomVc
        vc.edit = "1"
        vc.uidRef = uidR
        vc.rent = rent
        vc.houseNo = self.houseNo
        vc.imgArray = refImgArray
        vc.bedRooms = self.totalBed
        vc.floors = self.totalFloors
        vc.adType = self.addType
        vc.locationTo = self.busStand
        vc.contactNum = self.contactNum
        vc.locationArea = self.locationArea
        
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            SVProgressHUD.dismiss()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

    }
    
    @IBAction func setReminderAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReminderVc") as! ReminderVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func playBtnAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "play"){
            self.videoView.play()
            self.playBtn.setImage(UIImage(named: "pause"), for: .normal)
        }
        else{
            self.videoView.pause()
            self.playBtn.setImage(UIImage(named: "play"), for: .normal)
        }
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

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}


extension AdvHomeDetailVc : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvHomeDetailCollectionCell", for: indexPath) as! AdvHomeDetailCollectionCell
        let img = imagesArray[indexPath.row]
        cell.cellBackView.layer.cornerRadius = 10
        let postedImage = img
        let url = URL(string: postedImage)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                cell.advImageView?.image = UIImage(data: data!)
                self.refImgArray.append(cell.advImageView.image!)
            }
        }).resume()
        
        return cell
    }
    
    func loadImge(urrl : String?){
        
        var retImg : UIImage?
        
        if let postedImage = urrl{
                    let url = URL(string: postedImage)
                    URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                        if error != nil {
                            print(error!)
                        return
                        }
                        DispatchQueue.main.async {
                            print("images added in ret" ,(UIImage(data: data!)))
                             UIImage(data: data!)
                            
                        }
                        }).resume()
     }
        print(retImg, "is imagerRR")
        
    }
    
}

