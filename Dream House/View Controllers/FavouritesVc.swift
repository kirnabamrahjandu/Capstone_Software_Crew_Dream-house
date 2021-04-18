//
//  FavouritesVc.swift
//  Dream House
//
//  Created by Prince Kumar on 07/04/21.
//

import UIKit
import Firebase

class FavouritesVc: UIViewController {
    
    @IBOutlet var favouriteCollectionView: UICollectionView!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouriteCollectionView.delegate = self
        favouriteCollectionView.dataSource = self
        menuIcon()
        self.favouriteCollectionView.reloadData()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "Favourites"
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


}

extension FavouritesVc : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fvtModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionCell", for: indexPath) as! FavouriteCollectionCell
        cell.cellBackView.layer.cornerRadius = 8
        cell.ownerNameLabel.text = fvtModel[indexPath.row].ownerName ?? "not found"
        cell.moneyPerMonthLabel.text = "$" + (fvtModel[indexPath.row].rent ?? "") + " / Month"
        cell.cellBackView.layer.cornerRadius = 10
        cell.favouriteBtn.addTarget(self, action: #selector(removeFav(sender:)), for: .touchUpInside)
        cell.favouriteBtn.tag = indexPath.row
         let postedImage = fvtThumbnail[indexPath.row]
                    let url = URL(string: postedImage)
                    URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                        if error != nil {
                            print(error!)
                        return
                        }
                        DispatchQueue.main.async {
                            cell.houseImage?.image = UIImage(data: data!)
                        }
                        }).resume()
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.favouriteCollectionView.frame.width / 2 - 10 , height: self.favouriteCollectionView.frame.height / 3)
    }
    
    
    @objc func removeFav(sender: UIButton){
        UIButton.animate(withDuration: 1) {
            fvtModel.remove(at: sender.tag)
            fvtThumbnail.remove(at: sender.tag)
            self.favouriteCollectionView.reloadData()
        }

    }
    
    
}
