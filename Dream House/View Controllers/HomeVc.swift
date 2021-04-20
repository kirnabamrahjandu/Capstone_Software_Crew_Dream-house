//
//  HomeVc.swift
//  Dream House
//
//

import UIKit
import Firebase
import SVProgressHUD

class HomeVc: UIViewController {

    @IBOutlet var houseRoomSegmentBtn: UISegmentedControl!
    
    @IBOutlet var homeCollectionView: UICollectionView!
    
    @IBOutlet var searchTF: UITextField!
    
    @IBOutlet weak var searchTFBackView: UIView!
    
    var model = [Rent]()
    var imgArray = [[String]]()
    var protocolDelegate : hideTable?
    var hideViewDelegate : dismissView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        searchTFBackView.layer.cornerRadius = 10
        searchTF.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFBdata(findBy: "House")
        self.menuIcon()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "Home"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.model.removeAll()
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
                print(DataSnapshot, "is data")
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
                let imgArray = data["HouseImages"] as! [String]
                self.imgArray.append(imgArray)
                self.model.append(dummyModel)
                self.homeCollectionView.reloadData()
                SVProgressHUD.dismiss()
                
            }
            else{
                SVProgressHUD.dismiss()
            }
          }
        SVProgressHUD.dismiss()
      }
    
    func searchFBdata(key : String, value : String){
        SVProgressHUD.show()
          let ref = Database.database().reference().child("Rent")
          ref.queryOrdered(byChild: key).queryEqual(toValue: value).observeSingleEvent(of: .childAdded) { (DataSnapshot) in
            if DataSnapshot.exists() {
                SVProgressHUD.dismiss()
                print(DataSnapshot, "is data")
                
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
                let imgArray = data["HouseImages"] as! [String]
            dummyModel.childID = data["randomId"] as? String ?? ""
                self.imgArray.append(imgArray)
                self.model.append(dummyModel)
                self.homeCollectionView.reloadData()
                SVProgressHUD.dismiss()
                
            }
            else{
                SVProgressHUD.dismiss()
            }
          }
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
        let img = imgArray[indexPath.row].first
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
        cell.locationAddressLabel1.text = model[indexPath.row].locationHouse
        cell.favouriteBtn1.addTarget(self, action: #selector(favouriteTapped(sender:)), for: .touchUpInside)
        cell.favouriteBtn1.tag = indexPath.row
        return cell
    }
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.homeCollectionView.frame.width / 2) - (5), height: self.homeCollectionView.frame.height / 1.5)
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
        vc.uidR = self.model[indexPath.row].childId ?? ""
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var sa = [String]()
        sa.append(textField.text ?? "")
         UserDefaults.standard.setValue(sa, forKey: "search")
        self.searchTF.resignFirstResponder()
        self.hideViewDelegate?.hideView()
        return true
    }
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
