//
//  AllProductViewController.swift
//  GameHi
//
//  Created by prk on 12/4/23.
//

import UIKit
import CoreData

class AllProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var context: NSManagedObjectContext!
    
    var arr = [productModel]()
    let listPic = ["AssasinsCreed","TombRaider","Alienisolation","Cyberpunk","Forzahorizon", "Gta6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductTableView.dataSource = self
        ProductTableView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        readData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            deleteData(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let game = arr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductTableViewCell
        cell.productUP.text = "Product \(indexPath.row + 1)"
        cell.nameUP.text = game.name
        cell.priceUP.text = game.price
        cell.categoryUP.text = game.category
        cell.descUP.text = game.desc
        cell.imageUP.image = UIImage(named: listPic.randomElement()!)
        
        cell.handleUpdate = {self.updateData(indexPath: indexPath, cell: cell)}
        
        return cell
    }
    
    func dummyData(){
        arr.append(productModel(name: "Alien Isolation", price: "150000", category: "Horor", desc: "Horor Games with action"))
        arr.append(productModel(name: "Cyberpunk", price: "699000", category: "Open World", desc: "Enjoy Open World Game with Great Story"))
        arr.append(productModel(name: "Forza Horizon", price: "499000", category: "Racing", desc: "Best Game Racing in the world"))
        arr.append(productModel(name: "GTA VI", price: "799000", category: "Open World", desc: "Open World simulation game"))
    }
    
    func readData(){
        
        //Bikin Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        //Jalanin Request
        do{
            arr.removeAll()
            
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for data in result{
                arr.append(productModel(name: data.value(forKey: "name") as! String, price: data.value(forKey: "price") as? String ?? "1000", category: data.value(forKey: "category") as? String ?? "Games", desc: data.value(forKey: "desc") as? String ?? "makanan"))
            }
            
            ProductTableView.reloadData()
        }catch{
            print("Read Data Failed")
        }
    }
    
    func deleteData(indexPath: IndexPath){
        let name = arr[indexPath.row]
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name.name)
        
        do{
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for data in result{
                context.delete(data)
            }
            try context.save()
            readData()
        }catch{
            print("Delete Data Failed")
        }
    }
    
    func updateData(indexPath: IndexPath, cell: ProductTableViewCell){
        let oldName = arr[indexPath.row]
        
        let newName = cell.nameUP.text!
        let newPrice = cell.priceUP.text!
        let newCategory = cell.categoryUP.text!
        let newDesc = cell.descUP.text!
        
        if (newName.isEmpty){
            let alertController = UIAlertController(title: "Error", message: "Name cannot empty!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
        }
        
        if (newPrice.isEmpty){
            let alertController = UIAlertController(title: "Error", message: "Price cannot empty!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
        }
        if (newCategory.isEmpty){
            let alertController = UIAlertController(title: "Error", message: "Category cannot empty!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
        }
        if (newDesc.isEmpty && newDesc.count > 10){
            let alertController = UIAlertController(title: "Error", message: "Description cannot be empty and must more than 10 character!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "name == %@", oldName.name)
        
        do{
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            for data in result{
                data.setValue(newName, forKey: "name")
                data.setValue(newPrice, forKey: "price")
                data.setValue(newCategory, forKey: "category")
                data.setValue(newDesc, forKey: "desc")
            }
            try context.save()
            readData()
        }catch{
            print("Update Data Failed")
        }
    }
    
    

    @IBOutlet weak var ProductTableView: UITableView!
    
    

    
}
