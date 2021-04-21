//
//  SearchVc.swift
//  Dream House
//
//

import UIKit

class SearchVc: UIViewController{

    @IBOutlet var searchTableView: UITableView!

    var searchArray = [""]
    var delegate : hideTable?
    var hideV : dismissView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        menuIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let array = UserDefaults.standard.value(forKey: "search") as! [String]
        self.searchArray = array
        searchTableView.reloadData()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVc") as! HomeVc
        vc.hideViewDelegate = self
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

    @IBAction func dismissBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchVc :  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell") as! SearchTableCell
        cell.searchHistoryLabel.text = searchArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.hideTable(data: searchArray[indexPath.row])
    }
    
}


extension SearchVc : dismissView{
    func hideView() {
        print("protocol called")
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
