//
//  GenericConstants.swift
//  AccountsManagement
//
//  Created by Sachin Kumar on 23/02/24.
//
import Foundation

class GenericConstants {
    static let transactionListTableViewCell = "TransactionListTableViewCell"
    static let enterAmount = "Enter amount"
    static let done = "Done"
    static let accountNo = "Account Number:"
    static let accountBalance = "Account Balance:"
    static let accounType = "Account Type:"
    static let accounts = "Accounts"
    static let transactionViewController = "TransactionViewController"
    static let transactionDate = "Transaction Date: "
    static let transactionValue = "Transaction Value:"
    static let transactionType = "Transaction Type:"
    static let dateFormat = "dd MMM YYYY hh:mm a"
    static let alert = "Alert"
    static let ok = "OK"
    static let HelviticaFont = "Helvetica Neue"
    static let emptyString = ""
    static let negativeSign = "-"
    static let main = "Main"
    static let transaction = "Transaction"
}
enum ApiUrl {
    case account
    case transaction
    var Url: URL? {
        switch self {
        case .account:
            return URL(string: "https://m.timwang.au/accounts.json")
        case .transaction:
            return URL(string: "https://m.timwang.au/transactions.json")
        }
    }
}
enum CustomError: Error {
    case invalidData
    case invalidUrl
}
