//
//  PaymentViewController.swift
//  GameHi
//
//  Created by prk on 22/12/23.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var selectPay: UIButton!
    var totalRecived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUp()
        totalPrice.text = "Rp. \(totalRecived!)"
        
    }
    func setPopUp(){
        let optionClosure = {(action : UIAction ) in print(action.title)}
        selectPay.menu = UIMenu(children: [
            UIAction(title: "Select Payment",state: .on, handler: optionClosure),
            UIAction(title: "BCA",state: .on, handler: optionClosure),
            UIAction(title: "Mandiri",state: .on, handler: optionClosure),
            UIAction(title: "Gopay",state: .on, handler: optionClosure),
            UIAction(title: "OVO",state: .on, handler: optionClosure)
        ])
        selectPay.showsMenuAsPrimaryAction = true
        selectPay.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func onPayment(_ sender: Any) {
        let alertController = UIAlertController(title: "Payment Confirmation", message: "Your total price is \(totalRecived!). Are you sure want to pay?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Okay", style: .default) {(action) in
            self.toGuest()
        }
        let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(noAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func toGuest(){
        if let nextView = storyboard?.instantiateViewController(identifier: "guestView"){
            navigationController?.setViewControllers([nextView], animated: true)
        }
    }
    

}
