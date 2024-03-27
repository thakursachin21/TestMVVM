//
/*
 *	@file   TransactionListTableViewCell.swift
 *	@target AccountsManagement
 */

import UIKit

class TransactionListTableViewCell: UITableViewCell {
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // show transaction data in cell UI
    func setTransactionData(model: TransactionsDetail?) {
        guard let model = model else { return }
        let date = (model.date ?? 0.0).getDateString()
        self.transactionDateLabel.text = "\(GenericConstants.transactionDate)  \(date)"
        self.transactionValueLabel.text = "\(GenericConstants.transactionValue) \(model.value ?? 0)"
        self.transactionTypeLabel.text = "\(GenericConstants.transactionType) \(model.type ?? "")"
    }
}
