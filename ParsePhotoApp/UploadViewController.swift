//
//  UploadViewController.swift
//  ParsePhotoApp
//
//  Created by Oğulcan DEMİRTAŞ on 24.08.2021.
//

import UIKit
import Parse
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {  //kütüphaneden resim seçtirmek için delegateleri vermek laızm
    

    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var shareButtonPassive: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboardRecognizer)
        
        uploadImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        uploadImage.addGestureRecognizer(gestureRecognizer)
        shareButtonPassive.isEnabled = false
    }
    
    @objc func pickImage(){
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        shareButtonPassive.isEnabled = true
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
    
    @IBAction func shareButton(_ sender: Any) {
        shareButtonPassive.isEnabled = false //yanlışlıkla tekrar paylaş butonuna basmamak için. yeni resim yüklerken yine açılcak
        let post = PFObject(className: "post")
        let data = uploadImage.image?.jpegData(compressionQuality: 0.5) //yükleyeceğimiz image'i dataya çevirdik
        if let data = data {
            if PFUser.current() != nil {
                
                let parseImage = PFFileObject(name: "image.jpeg", data: data) //image'imizi parseüzerine bu şekilde kaydediyoruz
                post["image"] = parseImage
                post["comment"] = commentTextField.text!
                post["postuser"] = PFUser.current()?.username
                
                post.saveInBackground { success, error in //parse'a yorum,görsel ve kullanıcı kaydedip hata var mı yok mu bakıyoruz
                    if error != nil {
                        let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription ?? "UNKNOWN ERROR", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        
                        self.commentTextField.text = ""
                        self.uploadImage.image = UIImage(systemName: "photo")
                        self.tabBarController?.selectedIndex = 0
                        
                        NotificationCenter.default.post(name: NSNotification.Name("newpost"), object: nil) //yeni post paylaştığımızı uygulamaya söylüyor ve gidip serverdan çekiyor
                    }
                }
            }
            
        }
        
        performSegue(withIdentifier: "toFeedVC", sender: nil)
        
        
    }
    
}
