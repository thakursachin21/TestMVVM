//
//  TransactionViewModel.swift
//  AccountsManagement
//
//  Created by Sachin Kumar on 23/02/24.
//

import Foundation

typealias AccountListServiceCompletionHandler = (_ status: Bool) -> Void
class AccountListViewModel: ObservableObject {
    @Published var list = [AccountDetails]()
    
    // get account list and sort on basis acccount number
    func getAccountListData(completionHandler: @escaping AccountListServiceCompletionHandler) {
        NetworkManager.getResponse(url: ApiUrl.account.Url,
                                   expecting: [AccountDetails]?.self) { result in
             switch result {
             case .success(let data):
                 DispatchQueue.main.async {
                     if let data = data {
                         self.list = data.sorted(by: {$0.number ?? "" < $1.number ?? "" })
                     }
                     completionHandler(true)
                 }
             case .failure(_):
                 completionHandler(false)
             }
         }
     }
}
