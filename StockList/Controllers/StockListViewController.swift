//
//  StockListViewController.swift
//  StockList
//
//  Created by Yansong Wang on 2022/5/5.
//

import UIKit

class StockListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentSort: UISegmentedControl!
    
    private var viewModel: StockListViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Stock List"
        self.viewModel = StockListViewModel(delegate: self)
        self.viewModel.fetchStocks()
        self.segmentSort.setEnabled(false, forSegmentAt: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StockDetail", let destination = segue.destination as? StockDetailViewController, let index = self.tableView.indexPathForSelectedRow?.row, let stock = self.viewModel.stock(at: index) {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            destination.stock = stock
        }
    }
    
    @IBAction func actionSort(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.viewModel.sort(by: .name)
        } else {
            self.viewModel.sort(by: .price)
        }
    }
}

extension StockListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockListTableViewCell.identifier, for: indexPath) as! StockListTableViewCell
        
        if indexPath.row >= self.viewModel.currentCount {
            self.viewModel.showNext()
        }
        
        cell.configure(with: self.viewModel.stock(at: indexPath.row))
        
        return cell
    }
}

extension StockListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StockListViewController: StockListViewModelDelegate {
    func onFetchComplete() {
        DispatchQueue.main.async {
            self.segmentSort.setEnabled(true, forSegmentAt: 1)
            self.tableView.reloadData()
        }
    }
    
    func onFetchFailed(with reason: String) {
        
    }
}
