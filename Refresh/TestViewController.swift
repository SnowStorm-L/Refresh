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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath)
        cell.backgroundColor = .red
            
        
        return cell
    }
    
}
