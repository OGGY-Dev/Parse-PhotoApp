//
//  SettingsViewController.swift
//  ParsePhotoApp
//
//  Created by Oğulcan DEMİRTAŞ on 24.08.2021.
//

import UIKit
import Parse
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func signoutbutton(_ sender: Any) {
        self.performSegue(withIdentifier: "toVC", sender: nil)
        PFUser.logOutInBackground { error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription ?? "ERROR", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                
            }
            
        }
        
        
    }
    
}
