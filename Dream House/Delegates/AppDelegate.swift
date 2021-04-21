//
//  AppDelegate.swift
//  Dream House
//
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import FirebaseFirestore
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyA9KI4a2iAJq6vcQMMIXTRp9Cj8FTzAZGs")
        GMSPlacesClient.provideAPIKey("AIzaSyA9KI4a2iAJq6vcQMMIXTRp9Cj8FTzAZGs")
        GIDSignIn.sharedInstance().clientID = "877724214772-k7ao5j81o3vf8j8lgfjrji16b013ajqn.apps.googleusercontent.com"
                GIDSignIn.sharedInstance().delegate = self
        window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        return true
    }

    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        
           print(userId, idToken, fullName, givenName, familyName, email, "is data by google")
        // ...
    }
    
    func application(_ application: UIApplication,  open url: URL, sourceApplication: String?, annotation: Any) -> Bool{
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let data = userInfo as? [String:Any] {
            print(data)
        }
        
        print(userInfo)
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


