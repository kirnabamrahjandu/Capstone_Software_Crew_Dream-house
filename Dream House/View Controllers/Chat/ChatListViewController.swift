//
//  ChatListViewController.swift
//  Dream House
//
//

import UIKit
import Firebase
import FirebaseFirestore


class ChatListVc: UIViewController {

    @IBOutlet var chatListTableView: UITableView!
 
    var recNameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        chatListTableView.rowHeight = 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFireBaseData1()
        menuIcon()
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
    
    
    func getFireBaseData1() {
        var tempArray = [String]()
        let userId = Auth.auth().currentUser?.email ?? ""
        Firestore.firestore().collection("messages").whereField("sender", isEqualTo: userId).getDocuments { (snapShot, err) in
                 if let err = err {
                     
                     print("Error getting documents: \(err)")
                     
                 } else {
                    var tempArray = [String]()
                     for document in snapShot!.documents {
                         print("\(document.documentID) => \(document.data())")
                        self.recNameArray.append((document.data())["receiver"] as? String ?? "")
                        self.recNameArray.removeDuplicates()
                        self.chatListTableView.reloadData()
                     }
                     
                 }
             }
        getFireBaseData2()
      }
    
    func getFireBaseData2() {
        let userId = Auth.auth().currentUser?.email ?? ""
        Firestore.firestore().collection("messages").whereField("receiver", isEqualTo: userId).getDocuments { (snapShot, err) in
                 if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                    var tempArray = [String]()
                     for document in snapShot!.documents {
                         print("\(document.documentID) => \(document.data())")
                        self.recNameArray.append((document.data())["sender"] as? String ?? "")
                        self.recNameArray.removeDuplicates()
                        self.chatListTableView.reloadData()
                     }
                     
                 }
             }
           
      }
}


extension ChatListVc : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableCell") as! ChatListTableCell
        cell.receiverNamLabel.text = recNameArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.hidesBottomBarWhenPushed = true
        vc.sendTo = recNameArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}


extension RangeReplaceableCollection where Element: Hashable {
    var orderedSet: Self {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    mutating func removeDuplicates() {
        var set = Set<Element>()
        removeAll { !set.insert($0).inserted }
    }
}
