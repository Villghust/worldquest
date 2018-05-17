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
        
        if (FBSDKAccessToken.current() == nil){
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        } else {
            existePersonagem()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil){
            // Já está logado, vai para próxima tela.
            
            let usuarioId = Auth.auth().currentUser?.uid
            ref.child("usuarios").child(usuarioId!).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let personagem = value?["personagem"] as? String ?? ""
                
                if personagem == "" {
                    self.performSegue(
                        withIdentifier: "LoginToCharacterCreation",
                        sender: nil)
                } else {
                    self.performSegue(
                        withIdentifier: "LoginToGame",
                        sender: nil)
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func existePersonagem() {
        
    }
}

extension ViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Erro
        }
        else if result.isCancelled {
            // Cancelado
        }
        else {
            if result.grantedPermissions.contains("email")
            {
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
                    if error != nil {
                        // ...
                        return
                    }
                    // Logou!
                    self.ref.child("usuarios")
                        .child((user?.user.uid)!)
                        .setValue(["nome": user?.user.displayName])
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
