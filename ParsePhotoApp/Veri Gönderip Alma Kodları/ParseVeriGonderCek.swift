//
//  ViewController.swift
//  ParsePhotoApp
//
//  Created by Oğulcan DEMİRTAŞ on 24.08.2021.
//

import UIKit
import Parse

/* class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        let parseObject = PFObject(className: "Meyve" )    //Veri kaydetmek için kullanılırPFObject bir parse objesidir. Anahtar kelimeyi değere eşitliyoruz
         
        parseObject["isim"] = "Armut"
        parseObject["kalori"] = 150
        
        parseObject.saveInBackground { success, error in
            if error != nil {
                
                print(error?.localizedDescription)
                
            }else{
                print("upload bit ti")
            }
        }
       
        
      let query = PFQuery(className: "Meyve")   //PFQuaery veri tabanından veri çekmek için kullanılır.
        
        //query.whereKey("isim", equalTo: "elma") // çekeceğimiz veriyi wherekey equalTo ile filtreliyoruz
        query.whereKey("kalori", greaterThan: 100) //çekeeğimiz veriyi 100 den fazla kaloriye göre filtreledik
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription)
                
            }else{
                print(objects)
            }
        }
        
        
        
    }


} */

