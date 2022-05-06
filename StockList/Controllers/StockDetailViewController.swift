//
//  StockDetailViewController.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import UIKit

class StockDetailViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var labelExchange: UILabel!    
    
    @IBOutlet weak var labelType: UILabel!
    
    var stock: StockItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setData()
        // Do any additional setup after loading the view.
    }
    
    func setData() {
        if let stock = stock {
            self.title = stock.symbol
            self.labelName.text = "Name: \(stock.name)"
            self.labelPrice.text = "Price: \(stock.price.toDecimal()) USD"
            self.labelExchange.text = "Exchange: \(stock.exchange)"
            self.labelType.text = "Type: \(stock.type)"
        } else {
            self.title = "Stock"
            self.labelName.text = "Name: ..."
            self.labelPrice.text = "Price: ..."
            self.labelExchange.text = "Exchange: ..."
            self.labelType.text = "Type: ..."
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
