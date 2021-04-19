//
//  HomeVc.swift
//  Dream House
//
//

import UIKit
import Firebase

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
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFBdata()

    }
    
 
    @IBAction func searchLocationAction(_ sender: Any) {
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
    }
    
    @IBAction func sortBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SortByVc") as! SortByVc
       
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
     }
    
    func getFBdata(){
    
          let ref = Database.database().reference().child("Rent")
        ref.queryOrdered(byChild: "addType").queryEqual(toValue: "House").observe(.childAdded) { (DataSnapshot) in
            if DataSnapshot.exists() {
                
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
                let imgArray = data["HouseImages"] as! [String]
                self.imgArray.append(imgArray)
                self.model.append(dummyModel)
                self.homeCollectionView.reloadData()
                               
            }
            else{
              
            }
          }
    
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



