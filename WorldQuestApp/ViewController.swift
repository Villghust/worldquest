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
            
            let screenSize:CGRect = UIScreen.main.bounds
            let screenHeight = screenSize.height //real screen height
            //let's suppose we want to have 10 points bottom margin
            let newCenterY = screenHeight - loginView.frame.height - 50
            let newCenter = CGPoint(x: view.center.x, y: newCenterY)
            loginView.center = newCenter
            
            loginView.readPermissions = ["public_profile", "email"]
            loginView.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (Auth.auth().currentUser != nil){
            // Já está logado, vai para próxima tela.

            let usuarioId = Auth.auth().currentUser?.uid
            navegar(uid: usuarioId!)
        }
    }
    
    func navegar(uid: String) {
        ref.child("usuarios").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let personagem = value?["personagem"] as? NSObject
            
            // Se existe personagem, vai para a criação, senão vai para o mapa
            if personagem == nil {
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
                    
                    self.ref.child("usuarios").child((user?.user.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        let nome = value?["nome"] as? String
                        
                        if nome == nil {
                            let usuario = [
                                "nome": user?.user.displayName,
                                "foto": user?.user.photoURL?.absoluteString]
                            
                            self.ref.child("usuarios")
                                .child((user?.user.uid)!)
                                .setValue(usuario)
                        }
                        
                        self.navegar(uid: (user?.user.uid)!)
                        
                    }) { (error) in
                        print(error.localizedDescription)
                    }
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
