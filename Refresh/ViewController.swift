//
//  ViewController.swift
//  Refresh
//
//  Created by L on 2017/8/3.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testTableView: UITableView! {
        didSet {
            setupRefresh()
            testTableView.tableFooterView = UIView()
        }
    }
    
    lazy var testDataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupRefresh() {
        
        testTableView.headerView = RefreshHeader.headerRefreshing { [weak self] in
            print("走了")
            self?.loadData()
            self?.testTableView.reloadData()
        }
        
        testTableView.footerView = RefreshFooter.footerRefreshing {
            
        }
        
    }
    
    func loadData() {
        
        let random = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        for _ in 0..<5 {
            let index = Int(arc4random()%26)
            testDataSource.append(random[index])
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return testDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell") ?? UITableViewCell()
        cell.textLabel?.text = testDataSource[indexPath.row]
        
        return cell
    }
    
}

