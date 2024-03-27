//
//  AccountListViewController.swift
//  AccountsManagement
//
//  Created by Sachin Kumar on 23/02/24.
//

import SwiftUI
import UIKit

struct AccountListViewController: View {
    @ObservedObject var viewModel = AccountListViewModel()
    @State private var isShowingDetailView = false
    @State private var isLoading = true
    var body: some View {
        NavigationView() {
            ZStack {
                if isLoading {
                    ProgressView()
                }
                List(self.viewModel.list) { data in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(GenericConstants.accountNo) \(data.number ?? GenericConstants.emptyString)")
                        Text("\(GenericConstants.accountBalance) \(data.balance ?? 0)")
                        Text("\(GenericConstants.accounType) \(data.type ?? GenericConstants.emptyString)")
                        NavigationLink(destination: showTransactionDetailScreen()
                            .navigationTitle(GenericConstants.transaction)
                            .navigationBarTitleDisplayMode(.large)) {
                            }.navigationTitle(GenericConstants.accounts)
                            .opacity(0)
                    }.padding(EdgeInsets(top: 5, leading: 10, bottom: -5, trailing: 10))
                        .listRowBackground(Color.white)
                }.listStyle(.plain)
                    .onAppear() {
                        self.viewModel.getAccountListData { status in
                            self.isLoading = false
                        }
                    }
            }
        }.navigationBarTitleDisplayMode(.large)
    }
    
    func showTransactionDetailScreen() -> TransactionViewRepresentable {
        return TransactionViewRepresentable()
    }
}
// to navigate TransactionView
struct TransactionViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TransactionViewController {
        let storyBoard = UIStoryboard(name: GenericConstants.main, bundle: nil)
        let transactionVC = storyBoard.instantiateViewController(identifier: GenericConstants.transactionViewController) as! TransactionViewController
        return transactionVC
    }
    func updateUIViewController(_ uiViewController: TransactionViewController, context: Context) {}
}
extension AccountListViewController {
    func getAccountView() -> some View {
        return self
    }
}

