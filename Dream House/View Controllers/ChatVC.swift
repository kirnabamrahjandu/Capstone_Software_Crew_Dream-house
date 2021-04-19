//
//  ChatVC.swift
//  Dream House
//
//

import UIKit

class ChatVC: UIViewController {
    
 
    var messages = [String]()
   
    var sendTo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    @IBAction func sendPressed(_ sender: UIButton) {
 
    }

}

extension ChatVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
      
        return cell
    }
}

