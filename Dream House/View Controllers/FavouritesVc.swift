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
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.wishListCollectionView.frame.width / 2 - 10 , height: self.wishListCollectionView.frame.height / 3)
    }
    
    
    
}
