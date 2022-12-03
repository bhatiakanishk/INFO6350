//
//  OrderItemsTableViewCell.swift
//  Assignment9
//
//  Created by Gaurav Kohli on 11/19/22.
//

import UIKit

class OrderItemsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var item: Item?
    var tempSelectedOrderItems: OrderItems?
    
    var quantity: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDecreaseTap(_ sender: Any) {
        if let item = item, quantity > 0 {
            quantity -= 1
            quantityLabel.text = "\(quantity)"
            tempSelectedOrderItems?.items.removeAll { $0.item == item }
            tempSelectedOrderItems?.items.append(OrderItem(item: item, quantity: quantity))
        }
    }
    
    @IBAction func btnIncreaseTap(_ sender: Any) {
        if let item = item {
            quantity += 1
            quantityLabel.text = "\(quantity)"
            tempSelectedOrderItems?.items.removeAll { $0.item == item }
            tempSelectedOrderItems?.items.append(OrderItem(item: item, quantity: quantity))
        }
    }
}
