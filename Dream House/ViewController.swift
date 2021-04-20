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

struct K {
    static let appName = "Dream House"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        static let receiver = "receiver"
    }
}
