//
//  SearchVc.swift
//  Dream House
//
//

import UIKit

class SearchVc: UIViewController, UITableViewDataSource, UITableViewDelegate{


    @IBOutlet var searchTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    


    @IBAction func dismissBtnAction(_ sender: Any) {
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell") as! SearchTableCell
        cell.searchHistoryLabel.text = "Searched \(indexPath.row)"
        return cell
    }
    
}

