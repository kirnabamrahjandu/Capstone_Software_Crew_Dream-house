//
//  SortByVc.swift
//  Dream House
//
//

import UIKit

class SortByVc: UIViewController {
    
    var delegate : hideTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func busStandAction(_ sender: Any) {
        self.delegate?.sortListBy(key: "Location", value: "")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rentLow2HighAction(_ sender: Any) {
        self.delegate?.sortListBy(key: "Rent", value: "L2H")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rentHigh2LowAction(_ sender: Any) {
        self.delegate?.sortListBy(key: "Rent", value: "H2L")
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
