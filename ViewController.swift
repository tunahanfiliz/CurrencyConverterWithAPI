//
//  ViewController.swift
//  DovizCevirici
//
//  Created by Ios Developer on 9.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1 ) Request & Session                 url olustur istek at
        // 2 ) Response & Data                   veriyi al
        // 3 ) Parsing & JSON Serialization      işle
         
        
        //1.)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared // istediginiz ağa gidip ordna veri alışverişi yaptırır. shared demek o sınıftan obje çagırmak
        //closure
        let task = session.dataTask(with: url!) { data, response, error in
            // input veriyoruz yani url . karşılıgında sonuç alıyoruz completionhandlerden(entere bastık kayboldu)
            
            if error != nil{
                let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert) // error.localized ... kullanıcıya otomatik hata neyse gosterir
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true) // present neyi göstereyim demek alerti göster
          
            }else{       //  2.)
                
                if data != nil{
                    // infoya git app transport security aç onun içine de allow arbitary aç yese çevir HTTP lere izin vermek için.
                  
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>// dictionary oldugu için mutablecontainers seç
                        // yapılan işlem arkaplanda oldugu için sekronize olmayan sekilde yapmalıyız kasmasın çökmesin
                        DispatchQueue.main.async {
                            //jsonResponse yazdıgımızda buraya any oldugunu görürüz bize dictionary lazım let jsonResponse yazan yere çık ve ifadeyi as! dictionary<string,any> yap
                            // anahtar kelimeler string ama cevaplar öyle degil
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let turkish = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }

                            }
                        }
                   
                        
                        
                    }catch{
                        print("error")
                    }
                    
                    
                }
                
            }
        }
        task.resume() // bunu yazmazsan başlamaz. ve taskı kullanmıs olduk
        
    }
}

