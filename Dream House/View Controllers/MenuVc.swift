//
//  MenuVc.swift
//  Dream House
//
//

import UIKit

class MenuVc: UIViewController {
    
    @IBOutlet var menuTableView: UITableView!
    
    var menuOptionUser = ["Home", "Chats", "Favourites", "My Profile", "Logout"]

    var ref : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismissDetail()
    }
    
}

extension MenuVc : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return menuOptionUser.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableCell") as! MenuTableCell

            cell.menuOptionLabel.text = menuOptionUser[indexPath.row]
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
                self.selectIndex(index: 0)
                
            case 1:
                self.selectIndex(index: 1)
                
            case 2:
                self.selectIndex(index: 2)
            
            case 3:
                self.selectIndex(index: 3)
            
            
            case 4:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVc") as! WelcomeVc
                vc.hidesBottomBarWhenPushed = true
                self.ref?.navigationController?.setNavigationBarHidden(true, animated: true)
                self.ref?.navigationController?.pushViewController(vc, animated: true)
                self.dismiss(animated: true, completion: nil)
            default:
                print("default")
            }
        
    }
    
    @objc func dismissDetail() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.view.frame.origin = CGPoint(x: -self.view.frame.size.width, y:0)
            
        }) { (completion) in
            
            
            let transition = CATransition()
            
            transition.duration = 0.5
            
            transition.type = CATransitionType.fade
            
            transition.subtype = CATransitionSubtype.fromRight
            
            self.view.window?.layer.add(transition, forKey: kCATransition)
            
            
            
            self.dismiss(animated: false)
        }
        }
    
    func selectIndex(index: Int){
        self.ref?.tabBarController?.selectedIndex = index
        self.dismissDetail()
    }
    
}
