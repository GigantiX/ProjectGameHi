//
//  GuestTableViewCell.swift
//  GameHi
//
//  Created by prk on 12/19/23.
//

import UIKit

class GuestTableViewCell: UITableViewCell {
    
    var handleBuy = {}
    var handleRemove = {}

    @IBOutlet weak var ImageProduct: UIImageView!
    @IBOutlet weak var NameProduct: UILabel!
    @IBOutlet weak var DescProduct: UILabel!
    @IBOutlet weak var CategoryProduct: UILabel!
    @IBOutlet weak var PriceProduct: UILabel!
    
    @IBAction func onBuy(_ sender: Any) {
        handleBuy()
    }
    
    @IBAction func onRemove(_ sender: Any) {
        handleRemove()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
