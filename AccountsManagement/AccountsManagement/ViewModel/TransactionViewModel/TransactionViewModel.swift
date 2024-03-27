//
//  TransactionViewModel.swift
//  AccountsManagement
//
//  Created by Sachin Kumar on 23/02/24.
//

import Foundation
typealias TransactionListViewModelViewModelCompletionHandler = (_ status: Bool, _ error: String?) -> Void
class TransactionListViewModel {
    var transactionListModel: TransactionListModel?
    var filteredList: [TransactionsDetail] = [TransactionsDetail]()
    
    // get account list and sort on basis acccount number
    func getTransactionList(completionHandler: @escaping TransactionListViewModelViewModelCompletionHandler) {
        NetworkManager.getResponse(url: ApiUrl.transaction.Url,
                                   expecting: TransactionListModel?.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let list = data {
                        self.transactionListModel = list
                        self.filteredList = self.transactionListModel?.transactions ?? []
                        self.sortTransaction(isAscending: false)
                    }
                    completionHandler(true, nil)
                }
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
            }
        }
    }
    
    // filter transaction as per +/- amount
    func getFilterData(value: String?) {
        guard let transactions = self.transactionListModel?.transactions else { return }
        filteredList = transactions
        if (value?.isEmpty == true || value == GenericConstants.negativeSign) { filteredList = transactions }
        if let value = Int(value ?? "") {
            if value > 0 {
                filteredList = transactions.filter({ listItem in
                    return listItem.value ?? 0 >= value
                })
            } else {
                filteredList = transactions.filter({ listItem in
                    return listItem.value ?? 0 <= value
                })
            }
        }
    }
    // sort transaction as per transaction date
    func sortTransaction(isAscending: Bool) {
        guard let transactions = self.transactionListModel?.transactions else { return }
        if filteredList.count < 1 { filteredList = transactions }
        filteredList = isAscending ? filteredList.sorted(by: {$0.date ?? 0 < $1.date ?? 0 }) : filteredList.sorted(by: {$0.date ?? 0 > $1.date ?? 0 })
    }
    // get Date String
    func getDateString(value: Double) -> Date {
        return Date(timeIntervalSince1970: value)
    }
}
