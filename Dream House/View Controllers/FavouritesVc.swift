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

