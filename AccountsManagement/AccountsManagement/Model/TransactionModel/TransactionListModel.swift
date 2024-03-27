//
//  TransactionListModel.swift
//  AccountsManagement
//
//  Created by Sachin Kumar on 23/02/24.
//

struct TransactionListModel: Codable {
    var transactions: [TransactionsDetail]?
}
struct TransactionsDetail: Codable {
    let date: Double?
    let value: Int?
    let type: String?
}
