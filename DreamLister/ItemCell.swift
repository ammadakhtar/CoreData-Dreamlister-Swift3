//
//  ItemCell.swift
//  DreamLister
//
//  Created by Ammad on 30/01/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var type: UILabel!
    
    func configurecell(item: Item) {

        title.text = item.title
        price.text = "$\(item.price)"
        Details.text = item.details
        type.text = item.toItemType?.type
        thumb.image = item.toImage?.image as? UIImage
    }
    
}
