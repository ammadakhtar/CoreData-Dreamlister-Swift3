//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Ammad on 30/01/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }

}
