//
//  TestViewController.swift
//  Refresh
//
//  Created by L on 2017/8/24.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var testCollectionView: UICollectionView! {
        didSet {
            testCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TestCell")
        }
    }
    
    lazy var testDataSource = ["A", "B", "C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresh()
        
    }
    
    func setupRefresh() {
        
        testCollectionView.headerView = RefreshHeader.headerRefreshing { [weak self] in
            self?.endRefresh(isHeaderFresh: true)
        }
        
        (testCollectionView.headerView as? RefreshHeader)?.isAutomaticallyChangeAlpha = true
        
        testCollectionView.footerView = RefreshFooter.footerRefreshing { [weak self] in
            self?.endRefresh(isHeaderFresh: false)
        }
        
    }
    
    func endRefresh(isHeaderFresh: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if isHeaderFresh {
                if let headerReFresh = self.testCollectionView.headerView as? RefreshHeader {
                    self.loadData()
                    headerReFresh.endRefreshing()
                }
            } else {
                if let fooerRefresh = self.testCollectionView.footerView as? RefreshFooter {
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
        testCollectionView.reloadData()
    }
    
}

extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath)
        cell.backgroundColor = .red
            
        
        return cell
    }
    
}
