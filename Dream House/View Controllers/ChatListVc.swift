//
//  ChatListVc.swift
//  Dream House
//
//  Created by Prince Kumar on 19/04/21.
//

import UIKit

class ChatListVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
    


    @IBOutlet var chatListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatListTable.delegate = self
        chatListTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableCell") as! ChatListTableCell
        
        return cell
    }
    
}
