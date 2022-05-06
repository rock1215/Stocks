//
//  StockListTableViewCell.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import UIKit

class StockListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCode: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelExchange: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    
    static let identifier = "StockCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      
      configure(with: .none)
    }
    
    func configure(with stock: StockItem?) {
        if let stock = stock {
            self.labelCode.text = stock.symbol
            self.labelName.text = stock.name
            self.labelPrice.text = stock.price.toDecimal()
            self.labelExchange.text = stock.exchangeShortName
            
            self.labelCode.alpha = 1
            self.labelName.alpha = 1
            self.labelPrice.alpha = 1
            self.labelExchange.alpha = 1
            
            self.indicatorLoading.stopAnimating()
            self.indicatorLoading.alpha = 0
            
        } else {
            self.labelCode.alpha = 0
            self.labelName.alpha = 0
            self.labelPrice.alpha = 0
            self.labelExchange.alpha = 0
            
            self.indicatorLoading.startAnimating()
            self.indicatorLoading.alpha = 1
        }
    }
}
