//
//  MenuVc.swift
//  Dream House
//
//

import UIKit

class MenuVc: UIViewController {
    
    @IBOutlet var menuTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
       
    }
    
}

