//
//  SearchVc.swift
//  Dream House
//
//

import UIKit
import IQKeyboardManagerSwift

class SearchVc: UIViewController, UITextFieldDelegate{

    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var searchTF: UITextField!
    
    var searchArray = [""]
    var delegate : hideTable?
    var hideV : dismissView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTF.delegate = self
        
        menuIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let array = UserDefaults.standard.value(forKey: "search") as? [String] ?? [""]
        self.searchArray = array
        searchTF.becomeFirstResponder()
        searchTableView.reloadData()
        self.searchTF.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneTapped))
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.delegate?.hideTable(data: textField.text!)
        self.dismiss(animated: true, completion: nil)
        return true
    }
    
    @objc func doneTapped(){
        self.delegate?.hideTable(data: searchTF.text!)
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

