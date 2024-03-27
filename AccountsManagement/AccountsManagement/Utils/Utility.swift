//
//  Utility.swift
//  AccountsManagement
//
//  Created by Sachin Kumar on 23/02/24.
//

import Foundation
import UIKit

extension UITextField {
    typealias ToolbarItem = (title: String, target: Any, selector: Selector)
    
    func addToolBar(leading: [ToolbarItem] = [], trailing: [ToolbarItem] = []) {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let leadingItems = leading.map{ item in
            return UIBarButtonItem(title: item.title, style: .plain, target: item.target, action: item.selector)}
        
        let trailingItems = trailing.map { item in
            return UIBarButtonItem(title: item.title, style: .plain, target: item.target, action: item.selector)}
        
        var toolbarItems: [UIBarButtonItem] = leadingItems
        toolbarItems.append(flexibleSpace)
        toolbarItems.append(contentsOf: trailingItems)
        
        toolbar.setItems(toolbarItems, animated: false)
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
}

extension Double {
    func getDateString() -> String {
        let date =  Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.dateFormat = GenericConstants.dateFormat
        let dateString = formatter.string(from: date)
        return dateString
    }
}
