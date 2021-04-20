//
//  AdvHomeDetailVc.swift
//  Dream House
//
//

import UIKit
import MessageUI

class AdvHomeDetailVc: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var advHomeDetailCollectionView: UICollectionView!
    
    @IBOutlet var totalBedroomsTF: UITextField!
    
    @IBOutlet var totalFloorsTF: UITextField!
    
    @IBOutlet var rentPerMonth: UITextField!
    
    @IBOutlet var busStandLoc: UITextField!
    
    var contactNum = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        advHomeDetailCollectionView.delegate = self
        advHomeDetailCollectionView.dataSource = self
    }
    
    
    @IBAction func callAction(_ sender: Any) {
    
    }
    
    @IBAction func emailAction(_ sender: Any) {
        
    }
    
    @IBAction func messageAction(_ sender: Any) {

        
    }
    
 
}

extension AdvHomeDetailVc : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvHomeDetailCollectionCell", for: indexPath) as! AdvHomeDetailCollectionCell
        
        return cell
    }
    
    func callTapped() {
        guard let number = contactNum as? String ,
              let url = URL(string: "telprompt://\(number)") else{
            print("Number failed")
            return
        }
        UIApplication.shared.open(url)
    }
    
}
