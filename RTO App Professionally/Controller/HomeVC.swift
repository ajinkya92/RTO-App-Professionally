//
//  ViewController.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let data = DataService.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.getCategory().count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell {
            
            let categories = data.getCategory()[indexPath.row]
            
            cell.setupCategoryView(category: categories)
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let questionVC = storyboard?.instantiateViewController(withIdentifier: "QuestionVC") as! QuestionVC
            navigationController?.pushViewController(questionVC, animated: true)
        } else if indexPath.row == 1 {
            
            let practiceVC = storyboard?.instantiateViewController(withIdentifier: "PracticeVC") as! PracticeVC
            navigationController?.pushViewController(practiceVC, animated: true)
            
        } else if indexPath.row == 2 {
            
            let examVC = storyboard?.instantiateViewController(withIdentifier: "ExamVC") as! ExamVC
            navigationController?.pushViewController(examVC, animated: true)
        }
        
        
    }
    
    
}

