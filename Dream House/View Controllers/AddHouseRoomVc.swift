//
//  AddHouseRoomVc.swift
//  Dream House
//
//

import UIKit
import Firebase
import AVFoundation
import MobileCoreServices

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
    let autoComplete = GMSAutocompleteViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomHouse = "House"
        self.postBtn.setCornerRadius()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        autoComplete.delegate = self
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
       
            print(imageArray.count, "is slec")
            for i in 0..<imageArray.count{
                self.uploadImage(imageArray[i]) { (urrl) in
                    self.imagesURLArray.append(urrl!)
                    print(urrl, "is appended in array")
                    if self.imageArray.count == self.imagesURLArray.count{
                        print("serivce hitted")
                        self.uploadData(houseImage: self.imagesURLArray)
                    }
                    else{
                        print("loop in process")
                    }
                }
            }
            print("loop exited")
        }

    }
    
    @IBAction func skipAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarVc") as! MainTabBarVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func locationBtnAction(_ sender: Any) {
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                   UInt(GMSPlaceField.coordinate.rawValue) |
                   UInt(GMSPlaceField.addressComponents.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue))
               autoComplete.placeFields = fields
               
               // Specify a filter.
               let filter = GMSAutocompleteFilter()
               filter.type = .address
               autoComplete.autocompleteFilter = filter
               let token = GMSAutocompleteSessionToken.init()
               let placesClient = GMSPlacesClient()
               placesClient.findAutocompletePredictions(fromQuery: addressTF.text ?? "", filter: filter, sessionToken: token) { (results, error) in
                   if let error = error {
                       print("Autocomplete error: \(error)")
                       return
                   }
                   if let results = results {
                       for result in results {
                           print("Result \(result.attributedFullText.string) with placeID \(result.placeID)")
                       }
                   }
                   
               }
               
               self.present(autoComplete, animated: true, completion: nil)
           }
    
    
    
    func uploadImage(_ image:UIImage, completion: @escaping ((_ url: URL?) ->())){
        let imageName = NSUUID().uuidString
        let uid = Auth.auth().currentUser?.uid
        let storageRef = Storage.storage().reference().child("HouseImages").child("\(uid!)").child("\(imageName)")
        let imgData = image.pngData()
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
    
    func uploadData(houseImage: [URL]){
        
        var hImageArray = [String]()
        
        for i in 0..<(houseImage.count){
            let str = String(describing:houseImage[i])
            hImageArray.append(str)
        }
        let dict = ["ownerName": username, "Email": email, "Type": "Provider" ,"ProfilePic": userProfileURL, "Rent" : self.rentLabel.text, "Location": self.addressTF.text, "Phone": self.contactNumber.text, "busStand": self.locationToBusStandTF.text, "HouseImages": hImageArray, "userId": Auth.auth().currentUser?.uid ?? "", "addType": self.roomHouse, "totalRooms":self.numberOfRooms.text, "totalFloors": self.numberOfFloors.text] as [String : Any]
        
        let userRef = Database.database().reference().child("Rent").childByAutoId()
        userRef.updateChildValues(dict, withCompletionBlock: { (err, ref) in
            if err != nil{
                print(err!)
                return
            }
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Congratulations", message: "Yeah!, \n Your Add for \(self.roomHouse) is posted successfully. We will let you know, when someone interested in your Advertisement", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Login", style: .default, handler: {(UIAlertAction) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarVc") as! MainTabBarVc
                self.navigationController?.pushViewController(vc, animated: true)
            }
            )
            alert.addAction(restartAction)
            self.present(alert, animated: true, completion: nil)
            print("Registration Sucessfull")
            print("Data saved in firebase")
        })
    }



extension AddHouseRoomVc : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if info[UIImagePickerController.InfoKey.mediaType] as! String == "public.movie"{
            self.selectVideoBtn.setTitle("Video Selected", for: .normal)
            self.selectVideoBtn.isUserInteractionEnabled = false
            
        }
        else{
            self.imageArray.append(info[UIImagePickerController.InfoKey.editedImage] as! UIImage)
            self.imagesCollectionView.reloadData()
        }
        

        self.dismiss(animated: true, completion: nil)
    }
}



extension AddHouseRoomVc : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHouseRoomCollectionCell", for: indexPath) as! AddHouseRoomCollectionCell
        if imageArray.count == 3{
            self.selectImageBtn.isHidden = true
        }
        cell.advImageView.layer.cornerRadius = 10
        cell.advImageView.layer.borderWidth = 1
        cell.advImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.advImageView.image = imageArray[indexPath.row]
        return cell
    }

    
}

    
