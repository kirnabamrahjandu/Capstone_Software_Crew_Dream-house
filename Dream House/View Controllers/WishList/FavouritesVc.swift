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
        menuIcon()
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
        cell.cellBackView1.layer.cornerRadius = 8
        cell.ownerNameLabel1.text = fvtModel[indexPath.row].ownerName ?? "not found"
        cell.moneyPerMonthLabel1.text = "$" + (fvtModel[indexPath.row].rent ?? "") + " / Month"
        cell.cellBackView1.layer.cornerRadius = 10
        cell.favouriteBtn1.addTarget(self, action: #selector(removeFav(sender:)), for: .touchUpInside)
        cell.favouriteBtn1.tag = indexPath.row
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
    

    @objc func removeFav(sender: UIButton){
        UIButton.animate(withDuration: 1) {
            fvtModel.remove(at: sender.tag)
            fvtThumbnail.remove(at: sender.tag)
            self.wishListCollectionView.reloadData()
        }

    }
}
