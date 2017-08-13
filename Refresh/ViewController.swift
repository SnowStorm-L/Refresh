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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupRefresh() {
        
        testTableView.headerView = RefreshHeader.headerRefreshing {
            
        }
        
        testTableView.footerView = RefreshFooter.footerRefreshing {
            
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell") ?? UITableViewCell()
        
        return cell
    }
    
}

