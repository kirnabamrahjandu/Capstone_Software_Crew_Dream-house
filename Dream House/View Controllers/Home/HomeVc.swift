//
//  HomeVc.swift
//  Dream House
//
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
import AVFoundation
import MobileCoreServices
import FirebaseAuth
import SVProgressHUD

class HomeVc: UIViewController {
    
    @IBOutlet var houseRoomSegmentBtn: UISegmentedControl!
    
    @IBOutlet var homeCollectionView: UICollectionView!
    
    @IBOutlet var searchTF: UITextField!
    
    @IBOutlet weak var searchTFBackView: UIView!
    
    @IBOutlet var searchLocationBtn: UIButton!
    
    @IBOutlet var resetSearchBtn: UIButton!
    
    @IBOutlet var resetSearchConstant: NSLayoutConstraint!
    
    var model = [Rent]()
    var imgArray = [[String]]()
    var protocolDelegate : hideTable?
    var hideViewDelegate : dismissView?
    let autoComplete = GMSAutocompleteViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        searchTFBackView.layer.cornerRadius = 10
        searchTF.delegate = self
        autoComplete.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetSearchConstant.constant = 0
        getFBdata(findBy: "House")
        self.menuIcon()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "Home"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.model.removeAll()
    }
    
    @IBAction func resetSearchAction(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.model.removeAll()
            self.resetSearchConstant.constant = 0
            self.getFBdata(findBy: "House")
            self.searchTF.text = ""
        }

    }
    
    
    @IBAction func searchAction(_ sender: Any) {
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
        placesClient.findAutocompletePredictions(fromQuery: searchTF.text ?? "", filter: filter, sessionToken: token) { (results, error) in
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
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.model.removeAll()
            self.homeCollectionView.reloadData()
            getFBdata(findBy: "House")
        }
        else{
            self.model.removeAll()
            self.homeCollectionView.reloadData()
            getFBdata(findBy: "Room")
        }
    }
    
    @IBAction func sortBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SortByVc") as! SortByVc
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    func getFBdata(findBy : String){
        SVProgressHUD.show()
        let ref = Database.database().reference().child("Rent")
        ref.queryOrdered(byChild: "addType").queryEqual(toValue: findBy).observe(.childAdded) { (DataSnapshot) in
            if DataSnapshot.exists() {
                SVProgressHUD.dismiss()
                print(DataSnapshot, "is fetched")
                let data = DataSnapshot.value as! [String:Any]
                let dummyModel = Rent()
                dummyModel.ownerName = data["ownerName"] as? String ?? ""
                dummyModel.rent = data["Rent"]  as? String ?? ""
                dummyModel.locationHouse = data["Location"]  as? String ?? ""
                dummyModel.rooms = data["totalRooms"] as? String ?? ""
                dummyModel.floors = data["totalFloors"] as? String ?? ""
                dummyModel.locality = data["busStand"] as? String ?? ""
                dummyModel.emailAddress = data["Email"] as? String ?? ""
                dummyModel.contact = data["Phone"] as? String ?? ""
                dummyModel.childID = data["randomId"] as? String ?? ""
                dummyModel.userType = data["addType"] as? String ?? ""
                let imgArray = data["HouseImages"] as? [String] ?? [""]
                dummyModel.houseNo = data["houseNo"] as? String ?? ""
                dummyModel.video = data["video"] as? String ?? ""
                self.imgArray.append(imgArray)
                self.model.append(dummyModel)
                self.homeCollectionView.reloadData()
                SVProgressHUD.dismiss()
            }
            else{
                self.homeCollectionView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
        self.homeCollectionView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    func searchFBdata(key : String, value : String){
        self.model.removeAll()
        SVProgressHUD.show()
        let ref = Database.database().reference().child("Rent")
        ref.queryOrdered(byChild: key).queryEqual(toValue: value).observe(.childAdded) { (DataSnapshot) in
            if DataSnapshot.exists() {
                SVProgressHUD.dismiss()
                print(DataSnapshot, "is data")
                self.resetSearchConstant.constant = 35
                let data = DataSnapshot.value as! [String:Any]
                let dummyModel = Rent()
                dummyModel.ownerName = data["ownerName"] as? String ?? ""
                dummyModel.rent = data["Rent"]  as? String ?? ""
                dummyModel.locationHouse = data["Location"]  as? String ?? ""
                dummyModel.rooms = data["totalRooms"] as? String ?? ""
                dummyModel.floors = data["totalFloors"] as? String ?? ""
                dummyModel.locality = data["busStand"] as? String ?? ""
                dummyModel.contact = data["Phone"] as? String ?? ""
                dummyModel.emailAddress = data["Email"] as? String ?? ""
                let imgArray = data["HouseImages"] as? [String] ?? [""]
                dummyModel.childID = data["randomId"] as? String ?? ""
                dummyModel.userType = data["addType"] as? String ?? ""
                dummyModel.houseNo = data["houseNo"] as? String ?? ""
                dummyModel.video = data["video"] as? String ?? ""
                self.imgArray.append(imgArray)
                self.model.append(dummyModel)
                self.homeCollectionView.reloadData()
                SVProgressHUD.dismiss()
                
            }
            else{
                self.homeCollectionView.reloadData()
                self.resetSearchConstant.constant = 0
                SVProgressHUD.dismiss()
            }
        }
        self.homeCollectionView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    
    
}

extension HomeVc : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        cell.ownerNameLabel1.text = model[indexPath.row].ownerName ?? "not found"
        cell.moneyPerMonthLabel1.text = "$" + (model[indexPath.row].rent ?? "") + " / Month"
        cell.cellBackView1.layer.cornerRadius = 10
        if imgArray.count != 0 {
            let img = imgArray[indexPath.row].first
            if img != "" {
                if let postedImage = img {
                    let url = URL(string: postedImage)
                    URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        DispatchQueue.main.async {
                            cell.houseImage1?.image = UIImage(data: data!)
                        }
                    }).resume()
                }
            }
 
        }
        cell.locationAddressLabel1.text = model[indexPath.row].locationHouse
        cell.favouriteBtn1.addTarget(self, action: #selector(favouriteTapped(sender:)), for: .touchUpInside)
        cell.favouriteBtn1.tag = indexPath.row
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.homeCollectionView.frame.width / 2) - (5), height: 257)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AdvHomeDetailVc") as! AdvHomeDetailVc
        vc.busStand = model[indexPath.row].locality ?? "" + " KM Away"
        vc.imagesArray = self.imgArray[indexPath.row]
        vc.totalFloors = self.model[indexPath.row].floors ?? ""
        vc.rent = ("$ ") + (self.model[indexPath.row].rent ?? "")
        vc.totalBed = self.model[indexPath.row].rooms ?? ""
        vc.emailAdd = self.model[indexPath.row].emailAddress ?? ""
        vc.contactNum = self.model[indexPath.row].contact ?? ""
        vc.uidR = self.model[indexPath.row].childID ?? ""
        vc.locationArea = self.model[indexPath.row].locationHouse ?? ""
        vc.addType = model[indexPath.row].userType ?? ""
        vc.houseNo = model[indexPath.row].houseNo ?? ""
        vc.videoURL = model[indexPath.row].video ?? ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func menuIcon(){
        let navBarPlusButton = UIBarButtonItem(image: UIImage(named:  "menu"),  style: .plain, target: self, action: #selector(tabNavigations))
        navigationItem.leftBarButtonItem = navBarPlusButton
    }
    
    @objc func tabNavigations(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuVc") as! MenuVc
        vc.ref = self
        self.transitionVc(vc: vc, duration: 0.1, type: .fromLeft)
    }
    
    @objc func favouriteTapped(sender : UIButton){
        UIButton.animate(withDuration: 0.2,
                         animations: { sender.transform = CGAffineTransform(scaleX: 0.675, y: 0.66) },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.15, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
                         })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            sender.tintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            fvtModel.append(self.model[sender.tag])
            let img = self.imgArray[sender.tag].first
            fvtThumbnail.append(img ?? "")
        }
    }
    
    
}

extension HomeVc : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVc") as! SearchVc
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        var sa = [String]()
    //        sa.append(textField.text ?? "")
    //         UserDefaults.standard.setValue(sa, forKey: "search")
    //        self.searchTF.resignFirstResponder()
    //        self.hideViewDelegate?.hideView()
    //        return true
    //    }
}


extension HomeVc : hideTable{
    
    func hideTable(data: String) {
        print("delegate hitted \(data) received")
        self.searchTF.text = data
        self.searchTF.resignFirstResponder()
        self.searchFBdata(key: "Location", value: data)
    }
    
    func sortListBy(key : String, value: String) {
        self.sortedFBdata(key: key, value: value)
    }
    
    func sortedFBdata(key : String, value : String){
        
        if key == "Location"{
            var newRent = self.model
            newRent.sort {(Int($0.locality ?? "") ?? 0) < (Int($1.locality ?? "") ?? 0)}
            print(newRent)
            self.model = newRent
            self.homeCollectionView.reloadData()
        }
        else if value == "L2H"{
            var newRent = self.model
            newRent.sort {(Int($0.rent ?? "") ?? 0) < (Int($1.rent ?? "") ?? 0)}
            print(newRent)
            self.model = newRent
            self.homeCollectionView.reloadData()
        }
        else if value == "H2L"{
            var newRent = self.model
            newRent.sort {(Int($0.rent ?? "") ?? 0) > (Int($1.rent ?? "") ?? 0)}
            print(newRent)
            self.model = newRent
            self.homeCollectionView.reloadData()
        }
    }
}


extension HomeVc :GMSAutocompleteViewControllerDelegate, GMSAutocompleteResultsViewControllerDelegate{
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("original lat", place.coordinate.latitude)
        print("original long", place.coordinate.longitude)
        autoComplete.dismiss(animated: true, completion: nil)
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        autoComplete.dismiss(animated: true, completion: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        autoComplete.dismiss(animated: true, completion: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        print("Error: ", error.localizedDescription)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        print(prediction.attributedFullText, "did selected")
        searchTF.text = prediction.attributedFullText.string
        self.hideTable(data: prediction.attributedFullText.string)
        return true
    }
    
}
