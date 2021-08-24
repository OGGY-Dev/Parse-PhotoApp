//
//  ViewController.swift
//  ParsePhotoApp
//
//  Created by Oğulcan DEMİRTAŞ on 24.08.2021.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
       
        
    }

    @IBAction func signinButton(_ sender: Any) {
        
        
        if idTextField.text == "" && passwordTextField.text == "" {
            
            self.errorMessage(title: "Error", message: "Type Existing ID or Password ")
            
        }else{
            PFUser.logInWithUsername(inBackground: idTextField.text! , password: passwordTextField.text!) { user, error in
                if error != nil {
                    self.errorMessage(title: "Error", message: error?.localizedDescription ?? "ERROR")
                }else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
            
        }
        
    }
    
    @IBAction func signupButton(_ sender: Any) {
        if idTextField.text != "" && passwordTextField.text != "" {
            let user = PFUser()    //kullanıcıyı parse'a kaydetmek için PFUser() kullanıyoruz yine parse'ın bi özelliği
            user.username = idTextField.text!    //username ve password parse'ın kendi özellikleri
            user.password = passwordTextField.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.errorMessage(title: "Error", message: error?.localizedDescription ?? "ERROR")
                }else{
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
            
        }else{
            errorMessage(title: "Error", message: "Type User ID or Password")
        }
        
          
    }
    
    func errorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert) //uyarı verdircez
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil) //OK butonuna basınca bişey olmasın diye handler nil yaptık
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil) //verilen uyarıyı ekrana sunacaz
    }
    
}

