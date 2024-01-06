//
//  LoginAdminViewController.swift
//  GameHi
//
//  Created by prk on 12/4/23.
//

import UIKit
import CoreData

class LoginAdminViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var TFName: UITextField!
    
    @IBOutlet weak var TFPrice: UITextField!
    
    @IBOutlet weak var TFCategory: UITextField!
    
    @IBOutlet weak var TFDesc: UITextField!
    
    var context: NSManagedObjectContext!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        TFPrice.delegate = self
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == TFPrice {
            let allowedChar = "0987654321"
            let allowedChrSet = CharacterSet(charactersIn: allowedChar)
            let typedChrstIn = CharacterSet(charactersIn: string)
            let numbers = allowedChrSet.isSuperset(of: typedChrstIn)
            return numbers
        }
        return true
    }
    
    @IBAction func onChooseImage(_ sender: Any) {
        imgPick()
    }
    
    @IBAction func addProduct(_ sender: Any) {
        let name = TFName.text
        let price = TFPrice.text
        let category = TFCategory.text
        let desc = TFDesc.text
        
        
        
        if (name!.isEmpty){
            let alertController = UIAlertController(title: "Error", message: "Name cannot empty!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
        }
        
        if (price!.isEmpty){
            let alertController = UIAlertController(title: "Error", message: "Price cannot empty!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
        }
        if (category!.isEmpty){
            let alertController = UIAlertController(title: "Error", message: "Category cannot empty!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
        }
        if (desc!.isEmpty && desc!.count > 10){
            let alertController = UIAlertController(title: "Error", message: "Description cannot be empty and must more than 10 character!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
        }
        
        createData()
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] is UIImage{
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imgPick(){
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func createData(){
        let name = TFName.text
        let price = TFPrice.text
        let category = TFCategory.text
        let desc = TFDesc.text
        
        //Bikin entity
        let entityDescription = NSEntityDescription.entity(forEntityName: "Product", in: context)
        
        let entity = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        //Isi data ke entity
        entity.setValue(name, forKey: "name")
        entity.setValue(price, forKey: "price")
        entity.setValue(category, forKey: "category")
        entity.setValue(desc, forKey: "desc")
        
        //Save data ke database
        do{
            try context.save()
            
            let alertController = UIAlertController(title: "Success", message: "Data added succesfully!", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alertController.addAction(noAction)

            present(alertController, animated: true, completion: nil)
            
        }catch{
            print("Create Data Failed")
        }
    }
    
    
    @IBAction func toAllProduct(_ sender: Any) {
        if let nextView = storyboard?.instantiateViewController(identifier: "allProduct"){
            navigationController?.pushViewController(nextView, animated: true)
        }
    }
    
    func toLoginPage (){
        if let nextView = storyboard?.instantiateViewController(identifier: "landingPage"){
            navigationController?.setViewControllers([nextView], animated: true)
        }
    }
    
    
    //v Logout Func
    @IBAction func onAdminLogout(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Logout", style: .default) { (action) in
            self.toLoginPage()
                
        }
        
        let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(noAction)

        present(alertController, animated: true, completion: nil)
        
    }
    
}
