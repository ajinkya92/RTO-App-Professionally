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
    var imageQuestionDataArray = ImageQuestionElement()

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.setupSegmentControl()
        tableView.delegate = self
        tableView.dataSource = self
        getTextQuestionData()
        getImageQuestionData()
        
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        tableView.reloadData()
        
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
    
    func getImageQuestionData() {
        
        data.getImageQuestionData(url: IMAGEQUESTION_URL) { (ImageQuestionElement) in
            
            self.imageQuestionDataArray = ImageQuestionElement
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
}

// MARK: TableView Method Implementation

extension QuestionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentControl.selectedSegmentIndex == 0 {
            return textQuestionDataArray.count
        } else {
            
            return imageQuestionDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextQuestionCell") as! TextQuestionCell
            let textData = textQuestionDataArray[indexPath.row]
            cell.setupView(textQuestion: textData)
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageQuestionCell") as! ImageQuestionCell
            let imageData = imageQuestionDataArray[indexPath.row]
            cell.setupView(imageQuestion: imageData)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if segmentControl.selectedSegmentIndex == 0 {
            return UITableView.automaticDimension
        } else {
            return 150
        }
    }
    
    
    
}


