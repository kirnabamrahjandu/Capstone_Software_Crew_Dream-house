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
    }
    
    func getFireBaseData1() {
        let userId = Auth.auth().currentUser?.email ?? ""
        Firestore.firestore().collection("messages").whereField("sender", isEqualTo: userId).getDocuments { (snapShot, err) in
                 if let err = err {
                     
                     print("Error getting documents: \(err)")
                     
                 } else {
                    var tempArray = [String]()
                     for document in snapShot!.documents {
                         print("\(document.documentID) => \(document.data())")
                        self.recNameArray.append((document.data())["receiver"] as? String ?? "")
                        
                        let filtered = self.recNameArray.filter{$0 != Auth.auth().currentUser?.email}
                        self.recNameArray = filtered
                        let unique = self.recNameArray.orderedSet
                        
                        print(unique, "is array value")
                        self.recNameArray = unique
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
