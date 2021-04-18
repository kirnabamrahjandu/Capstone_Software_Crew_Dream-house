//
//  FavouritesVc.swift
//  Dream House
//
//  Created by Prince Kumar on 07/04/21.
//

import UIKit
import Firebase

class FavouritesVc: UIViewController {
    
        
    @IBOutlet var wishListCollectionView: UICollectionView!
    
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionCell", for: indexPath) as! FavouriteCollectionCell
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.favouriteCollectionView.frame.width / 2 - 10 , height: self.favouriteCollectionView.frame.height / 3)
    }
    
    
    
}
