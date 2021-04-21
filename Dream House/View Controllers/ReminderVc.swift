//
//  ReminderVc.swift
//  Dream House
//
//

import UIKit
import SkyFloatingLabelTextField
import UserNotifications

class ReminderVc: UIViewController {
    
    @IBOutlet var timePickerView: UIView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var reminderDescriptionTF: SkyFloatingLabelTextField!
    
    var date : Date?
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorderToView()
        setNavigationBar()
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = .current
        center.requestAuthorization(options: [.alert, .sound]) { (granted, errr) in
            if granted{
                print("Approved")
            }
            else{
                print("Rejected")
            }
        }
        self.datePicker.addTarget(self, action: #selector(didTapDatePicker), for: .touchUpInside)
       // datePicker.isUserInteractionEnabled = false
    }

    
    
    func setBorderToView(){
        self.timePickerView.layer.borderColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        self.timePickerView.layer.borderWidth = 2
        self.timePickerView.layer.cornerRadius = 2
        self.timePickerView.clipsToBounds = true

        

        

     
    }
    
    func setNavigationBar(){
        let backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "backImage"), for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 198/255, green: 206/255, blue: 216/255, alpha: 1.0)
        self.navigationItem.title = "Setup A Reminder"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 20)!]
    }
    
    
    func triggerNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Dream House"
        content.body = self.reminderDescriptionTF.text!
        
        let dateComponnent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self.date!)
        
        
      let trigger =  UNCalendarNotificationTrigger(dateMatching: dateComponnent, repeats: false)
        let strUID = UUID().uuidString
       let req = UNNotificationRequest(identifier: strUID, content: content, trigger: trigger)
        center.add(req) { (errr) in
            print(errr?.localizedDescription, "is error")
        }
    }

    //MARK:- OBJC Functions
    
    @objc func didTapBackBtn(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapDatePicker(sender:UIDatePicker){
        //datePicker.isUserInteractionEnabled = true
    }
    
    //MARK:- IBActions
    
    
    @IBAction func tappedSaveBtn(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "MMM d, h:mm a"

        let receivedTime = dateFormatter.string(from: datePicker.date)
        print(receivedTime)
        
    
        let alert = UIAlertController(title: "Yeah", message: "Reminder has been set for \(receivedTime)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (alert1) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.date = datePicker.date
        
        self.triggerNotification()
        self.present(alert, animated: true, completion: nil)
    }
    
}

