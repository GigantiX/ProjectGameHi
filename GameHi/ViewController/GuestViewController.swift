//
//  GuestViewController.swift
//  GameHi
//
//  Created by prk on 12/4/23.
//

import UIKit
import CoreData

class GuestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var proArr = [productModel]()
    var context: NSManagedObjectContext!
    var total = 0
    
    let listPic = ["AssasinsCreed","TombRaider","Alienisolation","Cyberpunk","Forzahorizon", "Gta6"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let game = proArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameview") as! GuestTableViewCell
        cell.NameProduct.text = game.name
        cell.PriceProduct.text = ("Rp. \(game.price)")
        cell.CategoryProduct.text = game.category
        cell.DescProduct.text = game.desc
        cell.ImageProduct.image = UIImage(named: listPic.randomElement()!)
        cell.handleBuy = {self.buyProduct(price: Int(game.price)!)}
        cell.handleRemove = {self.removeProduct(price: Int(game.price)!)}
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    
    @IBOutlet weak var PriceTF: UILabel!
    
    @IBOutlet weak var GameTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GameTableView.dataSource = self
        GameTableView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        readData()
        
    }
    
    func buyProduct(price: Int){
        total = total + price
        PriceTF.text = String(total)
    }
    
    func removeProduct(price: Int){
        if (price != 0){
            total = total - price
            PriceTF.text = String(total)
        }
    }
    
    func toLoginPage (){
        if let nextView = storyboard?.instantiateViewController(identifier: "landingPage"){
            navigationController?.setViewControllers([nextView], animated: true)
        }
    }
    
    func dummyData(){
        proArr.append(productModel(name: "Alien Isolation", price: "150000", category: "Horor", desc: "Horor Games with action"))
        proArr.append(productModel(name: "Cyberpunk", price: "699000", category: "Open World", desc: "Enjoy Open World Game with Great Story"))
        proArr.append(productModel(name: "Forza Horizon", price: "499000", category: "Racing", desc: "Best Game Racing in the world"))
        proArr.append(productModel(name: "GTA VI", price: "799000", category: "Open World", desc: "Open World simulation game"))
    }
    
    func readData(){
        
        //Bikin Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        //Jalanin Request
        do{
            proArr.removeAll()
            
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for data in result{
                proArr.append(productModel(name: data.value(forKey: "name") as! String, price: data.value(forKey: "price") as? String ?? "1000", category: data.value(forKey: "category") as? String ?? "Games", desc: data.value(forKey: "desc") as? String ?? "makanan"))
            }
            GameTableView.reloadData()
            
        }catch{
            print("Read Data Failed")
        }
    }
    
    @IBAction func onGuestLogout(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Logout", style: .default) { (action) in
            self.toLoginPage()
                
        }
        
        let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(noAction)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onCheckout(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(identifier: "paymentView"){
            var paymentPG = nextView as! PaymentViewController
            paymentPG.totalRecived = String(total)
            
            navigationController?.pushViewController(nextView, animated: true)
        }
    }
    
}
