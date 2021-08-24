//
//  FeedViewController.swift
//  ParsePhotoApp
//
//  Created by Oğulcan DEMİRTAŞ on 24.08.2021.
//

import UIKit
import Parse
class FeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray = [Post]() //postlardan oluşan bir dizi olacağını söylüyoruz-post yapısını tutucaz.Modelimizdeki post sınıfını çağırdık
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    //FeedviewController her açıldığında kontrol etmesi için aşağıdaki fonksiyonu kullanıyoruz. Her yeni post bildirimi aldığında getData fonksiyonunu çağırcak
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newpost"), object: nil)
    }
    //verileri aşağıdaki fonksiyonla query ile çekiyoruz
    @objc func getData() {
        let query = PFQuery(className: "post")
        query.addDescendingOrder("createdAt") //createdAt back4app dashboarddaki tarih sıralaması. Yeniden eskiye göre dizdircez postları
        query.findObjectsInBackground { objects, error in
            if error != nil{
                self.errorMessage(title: "ERROR", message: error?.localizedDescription ?? "UNKNOWN ERROR")
                
            }else{
                if objects != nil {
                    if objects!.count > 0 {
                        self.postArray.removeAll(keepingCapacity: false) //post dizisindeki veriyi tutma içinde boş yere temizle
                        
                        for object in objects! {
                            if let userName = object.object(forKey: "postuser") as? String{
                                if let userComment = object.object(forKey: "comment") as? String{
                                    if let userImage = object.object(forKey: "image") as? PFFileObject {
                                        let post = Post(username: userName, usercomment: userComment, userImage: userImage)
                                        
                                        self.postArray.append(post)
                                    }
                                }
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    
    }
    func errorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell //tekrarlanan cell şekli yapıyoruz
        cell.usernameLabel.text = postArray[indexPath.row].username
        cell.commentLabel.text = postArray[indexPath.row].usercomment
        postArray[indexPath.row].userImage.getDataInBackground { data, error in
            if error == nil{
                if let data = data {
                    cell.postImage.image = UIImage(data: data)
                }
                
            }
        }
        return cell
    }

}
