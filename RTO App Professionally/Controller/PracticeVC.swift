//
//  PracticeVC.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 26/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class PracticeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let data = PracticeDataService.instance
    var practiceDataArray = PracticeElement()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        getPracticeData()
        
    }
    

}

// MARK: API Call to get Data from Data Services

extension PracticeVC {
    
    func getPracticeData() {
        
        data.getPracticeData(url: PRACTICE_URL) { (PracticeElement) in
            
            self.practiceDataArray = PracticeElement
            
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
            }
            
        }
        
        
    }
    
}


// MARK: Practice Collection View Implementation

extension PracticeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return practiceDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PracticeCollectionCell", for: indexPath) as? PracticeCollectionCell {
            
            cell.tableView.tag = indexPath.row
            
            cell.tableView.delegate = nil
            cell.tableView.dataSource = nil
            
            cell.tableView.delegate = self
            cell.tableView.dataSource = self
            
            cell.tableView.reloadData()
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 600)
    }
    
    
}

// MARK: Practice Table View Implementation

extension PracticeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeTableCell") as? PracticeTableCell {
            
            let practiceData = practiceDataArray[tableView.tag]
            cell.setupView(practice: practiceData)
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 500
    }
    
}
