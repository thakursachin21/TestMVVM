//
//  TransactionViewController.swift
//  AccountsManagement
//
//  Created by Sachin Kumar on 23/02/24.
//

import UIKit

class TransactionViewController: UIViewController {
    @IBOutlet weak var dateSortButton: UIButton!
    @IBOutlet weak var transactionSearchField: UITextField!
    @IBOutlet weak var transactionTableView: UITableView!
    var viewModel = TransactionListViewModel()
    var isAscendingOrder = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.getTransactionData()
    }
    
    // initialize view and register tableViewCell
    func setUpView() {
        self.transactionTableView.register(UINib(nibName: GenericConstants.transactionListTableViewCell, bundle: nil), forCellReuseIdentifier: GenericConstants.transactionListTableViewCell)
        self.transactionSearchField.keyboardType = .numberPad
        self.transactionSearchField.addTarget(self, action: #selector(self.textFieldDidChange(_ :)), for: .editingChanged)
        self.transactionSearchField.placeholder = GenericConstants.enterAmount
        self.createToolBarButton()
    }
    
    func createToolBarButton() {
        let leftButton = UITextField.ToolbarItem(title: GenericConstants.negativeSign, target: self, selector: #selector(leftToolBarButtonAction(_ :)))
        let rightButton = UITextField.ToolbarItem(title: GenericConstants.done, target: self, selector: #selector(done(_ :)))
        self.transactionSearchField.addToolBar(leading: [leftButton], trailing: [rightButton])
    }
    // textField value change and show filter value
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.getFilterData(value: textField.text ?? GenericConstants.emptyString)
        self.transactionTableView.reloadData()
    }
    // negative sign enter to filter negative value
    @objc func leftToolBarButtonAction(_ textField: UITextField) {
        guard let value = transactionSearchField.text else {
            return
        }
        if value.hasPrefix(GenericConstants.negativeSign) {
            let offsetIndex = value.index(value.startIndex, offsetBy: 1)
            let subString = value[offsetIndex...]
            transactionSearchField.text = String(subString)
        } else {
            transactionSearchField.text = GenericConstants.negativeSign + value
        }
        self.viewModel.getFilterData(value: transactionSearchField.text)
    }
    @objc func done(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    @IBAction func sortByDate(_ sender: Any) {
        self.isAscendingOrder = !self.isAscendingOrder
        self.viewModel.sortTransaction(isAscending: isAscendingOrder)
        self.transactionTableView.reloadData()
    }
    // get Transaction Data from Server
    func getTransactionData() {
        viewModel.getTransactionList { [weak self] status, errorMsg in
            guard let self = self else { return }
            if status {
                if self.viewModel.transactionListModel != nil {
                    self.transactionTableView.reloadData()
                }
            } else {
                if let errorMsg = errorMsg {
                    let alert = UIAlertController(title: GenericConstants.alert, message: errorMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: GenericConstants.ok, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
// UITableview Delegates
extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = transactionTableView.dequeueReusableCell(withIdentifier: GenericConstants.transactionListTableViewCell) as? TransactionListTableViewCell else {
            return UITableViewCell()
        }
        let item = self.viewModel.filteredList[indexPath.row]
        cell.setTransactionData(model: item)
        return cell
    }
}
