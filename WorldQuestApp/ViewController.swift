//
//  ViewController.swift
//  WorldQuestApp
//
//  Created by Alan Quadros on 11/05/2018.
//  Copyright © 2018 World Quest. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        if (FBSDKAccessToken.current() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
}

extension ViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
                    if error != nil {
                        // ...
                        return
                    }
                    // User is signed in
                    self.ref.child("usuario")
                        .child((user?.user.uid)!)
                        .setValue(["username": user?.user.displayName])
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
}
