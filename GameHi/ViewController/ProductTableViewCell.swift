//
//  ProductTableViewCell.swift
//  GameHi
//
//  Created by prk on 11/12/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var handleUpdate = {}
    
    @IBOutlet weak var productUP: UILabel!
    @IBOutlet weak var nameUP: UITextField!
    @IBOutlet weak var priceUP: UITextField!
    @IBOutlet weak var categoryUP: UITextField!
    @IBOutlet weak var descUP: UITextField!
    @IBOutlet weak var imageUP: UIImageView!
    
    @IBAction func onUpdate(_ sender: Any) {
        handleUpdate()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        priceUP.delegate = self
        // Initialization code
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == priceUP {
            let allowedChar = "0987654321"
            let allowedChrSet = CharacterSet(charactersIn: allowedChar)
            let typedChrstIn = CharacterSet(charactersIn: string)
            let numbers = allowedChrSet.isSuperset(of: typedChrstIn)
            return numbers
        }
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
