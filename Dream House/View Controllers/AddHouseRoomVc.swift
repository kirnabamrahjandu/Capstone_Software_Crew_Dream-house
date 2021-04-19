//
//  AddHouseRoomVc.swift
//  Dream House
//
//

import UIKit
import Firebase


class AddHouseRoomVc: UIViewController {
    
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet var segmentBtn: UISegmentedControl!
    @IBOutlet var houseNoTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var selectImageBtn: UIButton!
    @IBOutlet var rentLabel: UITextField!
    @IBOutlet var contactNumber: UITextField!
    @IBOutlet var locationToBusStandTF: UITextField!
    @IBOutlet var skipBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var numberOfRooms: UITextField!
    @IBOutlet weak var numberOfFloors: UITextField!
    @IBOutlet weak var selectVideoBtn: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var roomHouse = ""
    var imageArray = [UIImage]()
    var imagesURLArray = [URL]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomHouse = "House"
    
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
      
        imagePicker.delegate = self
        self.selectVideoBtn.layer.cornerRadius = 10
        self.selectImageBtn.layer.cornerRadius = self.selectImageBtn.layer.frame.height / 2
    }
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.roomHouse = "House"
        }
        else{
            self.roomHouse = "Room"
        }
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func selectVideoAction(_ sender: Any) {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.mediaTypes = [kUTTypeMovie as String]
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postAction(_ sender: Any) {
            for i in 0..<imageArray.count{
                self.uploadImage(imageArray[i]) { (urrl) in
                    self.imagesURLArray.append(urrl!)
                    print(urrl, "is appended in array")
                    if self.imageArray.count == self.imagesURLArray.count{
                        print("serivce hitted")
                        self.uploadData(houseImage: self.imagesURLArray)
                    }
                    else{
                      
                    }
                }
            }
          
        

    }
    
    @IBAction func skipAction(_ sender: Any) {

    }
    
    @IBAction func locationBtnAction(_ sender: Any) {
    }
    
    
    
}
