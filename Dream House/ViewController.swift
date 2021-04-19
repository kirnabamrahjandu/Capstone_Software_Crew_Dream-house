//
//  ViewController.swift
//  Dream House
//
//

import UIKit

extension UIViewController {



}

@objc protocol hideTable {
    func hideTable(data : String)
    
    func sortListBy(key : String, value : String)
}

protocol dismissView {
    func hideView()
}

var username = ""
var email = ""
var userProfileURL = ""
var fvtModel = [Rent]()
var fvtThumbnail = [String]()
var userType = ""
