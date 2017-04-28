//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Ammad on 31/01/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var thumgImg: UIImageView!
    @IBOutlet weak var typefield: CustomTextField!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        storePicker.dataSource = self
        storePicker.delegate = self
        
        
        if let topitem = self.navigationController?.navigationBar.topItem {
            topitem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     let store = stores[row]
        return store.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return stores.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //update
    }
    
    func getStores()
    {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
            // If Stores have never been loaded, add them and reload
            if self.stores.count == 0 {
                self.generateStores()
                self.getStores()
            }
            
        } catch{
            let error = error as NSError
            print(error.debugDescription)
        

        }
        
    }
    
    
    @IBAction func SavePressed(_ sender: UIButton) {
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumgImg.image
        let itemtype = ItemType(context: context)
        itemtype.type = typefield.text
        
        if itemToEdit == nil
        {
            item = Item(context: context)
        }
        else
        {
            item = itemToEdit
        }
        
        item.toImage = picture
        item.toItemType = itemtype
        
        
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }

        
        item.toStore  = stores[storePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text =  "\(item.price)"
            detailsField.text = item.details
            typefield.text = item.toItemType!.type
            
            thumgImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat
                {
                    let s = stores[index]
                    if s.name == store.name
                      {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                      }
                      index += 1
                    
                } while(index < stores.count)
            }
            
        }
        
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            thumgImg.image = img
        }
    imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func generateStores() {
        let store = Store(context: context)
        store.name = "Walmart"
        let store2 = Store(context: context)
        store2.name = "Apple"
        let store3 = Store(context: context)
        store3.name = "Ford"
        let store4 = Store(context: context)
        store4.name = "Beats"
        let store5 = Store(context: context)
        store5.name = "Samsung"
        let store6 = Store(context: context)
        store6.name = "Phillips"
        let store7 = Store(context: context)
        store7.name = "SONY"
        let store8 = Store(context: context)
        store8.name = "QMobile"
        
        ad.saveContext()
    }
    
    
    
    
}
