//
//  FavouritesVc.swift
//  Dream House
//
//

import UIKit


class FavouritesVc: UIViewController {
    
        
    @IBOutlet var wishListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        wishListCollectionView.delegate = self
        wishListCollectionView.dataSource = self
        self.wishListCollectionView.reloadData()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "Favourites"
    }
    


}

extension FavouritesVc : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionCell", for: indexPath) as! FavouriteCollectionCell
        cell.cellBackView1.layer.cornerRadius = 8
        cell.ownerNameLabel1.text = fvtModel[indexPath.row].ownerName ?? "not found"
        cell.moneyPerMonthLabel1.text = "$" + (fvtModel[indexPath.row].rent ?? "") + " / Month"
        cell.cellBackView1.layer.cornerRadius = 10
         let postedImage = fvtThumbnail[indexPath.row]
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
     
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.wishListCollectionView.frame.width / 2 - 10 , height: self.wishListCollectionView.frame.height / 3)
    }
    

    
}
