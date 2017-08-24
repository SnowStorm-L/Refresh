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
            testTableView.tableFooterView = UIView()
        }
    }
    
    lazy var testDataSource = ["A", "B", "C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresh()
        
    }
    
    func setupRefresh() {
        
        testTableView.headerView = RefreshHeader.headerRefreshing { [weak self] in
            self?.endRefresh(isHeaderFresh: true)
        }
        
        (testTableView.headerView as? RefreshHeader)?.isAutomaticallyChangeAlpha = true
        
        testTableView.footerView = RefreshFooter.footerRefreshing { [weak self] in
            self?.endRefresh(isHeaderFresh: false)
        }
        
    }
    
    func endRefresh(isHeaderFresh: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if isHeaderFresh {
                if let headerReFresh = self.testTableView.headerView as? RefreshHeader {
                    self.loadData()
                    headerReFresh.endRefreshing()
                }
            } else {
                if let fooerRefresh = self.testTableView.footerView as? RefreshFooter {
                    self.loadData()
                    fooerRefresh.endRefreshing()
                }
            }
        }
    }
    
    func loadData() {
        
        let random = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        for _ in 0..<5 {
            let index = Int(arc4random()%26)
            testDataSource.append(random[index])
        }
        testTableView.reloadData()
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

