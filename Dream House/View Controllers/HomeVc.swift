//
//  HomeVc.swift
//  Dream House
//
//

import UIKit


class HomeVc: UIViewController {
    
    @IBOutlet var houseRoomSegmentBtn: UISegmentedControl!
    
    @IBOutlet var homeCollectionView: UICollectionView!
    
    @IBOutlet var searchTF: UITextField!
    
    @IBOutlet weak var searchTFBackView: UIView!

    var model = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      
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

    
}

extension HomeVc : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        cell.ownerNameLabel1.text = "Owner \(indexPath.row)"
        return cell
    }
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.homeCollectionView.frame.width / 2) - (5), height: self.homeCollectionView.frame.height / 1.5)
    }
    
    

}
