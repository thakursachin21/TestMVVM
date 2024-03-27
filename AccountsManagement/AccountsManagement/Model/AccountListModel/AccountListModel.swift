//
//  TransactionListModel.swift
//  AccountsManagement
//
//  Created by Sachin Kumar on 23/02/24.
//

import Foundation

struct AccountDetails: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case balance
        case number
        case type
    }
    var id = UUID().uuidString
    let balance: Int?
    let number: String?
    let type: String?
}
