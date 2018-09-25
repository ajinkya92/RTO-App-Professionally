//
//  QuestionVC.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 25/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let data = QuestionDataService.instance
    
    var textQuestionDataArray = TextQuestionElement()

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.setupSegmentControl()
        tableView.delegate = self
        tableView.dataSource = self
        getTextQuestionData()
        
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            getTextQuestionData()

        } else {
            
            return
        }
        
        
    }
    

}

// MARK: Fetching Data Methods from Data Service

extension QuestionVC {
    
    func getTextQuestionData() {
        
        data.getTextQuestionData(url: TEXTQUESTION_URL) { (TextQuestionElement) in
            
            self.textQuestionDataArray = TextQuestionElement
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
}

// MARK: TableView Method Implementation

extension QuestionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return textQuestionDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TextQuestionCell") as? TextQuestionCell {
            
            let textData = textQuestionDataArray[indexPath.row]
            
            cell.setupView(textQuestion: textData)
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
        
    }
    
    
}

