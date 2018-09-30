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
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    let data = PracticeDataService.instance
    var practiceDataArray = PracticeElement()
    var answersDataArray = [String]()
    
    // Answer Checking Variables
    
    var shouldSelectRightAnswer = false
    var rightAnswer = String()
    var selectedAnswer: Int?
    
    var createdRowIndexpath = Int()
    var currentQuestion = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createdRowIndexpath = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        getPracticeData()
        previousButton.isHidden = true
        
        
    }
    
    //MARK: IBActions & Functions
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        
        var indexpath = IndexPath(row: createdRowIndexpath, section: 0)
        
        if indexpath.row >= 0 {
            
            createdRowIndexpath -= 1
            currentQuestion -= 1
            indexpath = IndexPath(row: createdRowIndexpath, section: 0)
            collectionView.scrollToItem(at: indexpath, at: .right, animated: true)
            questionNumberLabel.text = "\(currentQuestion)"
            
        }
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        var indexpath = IndexPath(row: createdRowIndexpath, section: 0)
        
        if indexpath.row <= practiceDataArray.count - 1 {
            
            createdRowIndexpath += 1
            currentQuestion += 1
            indexpath = IndexPath(row: createdRowIndexpath, section: 0)
            collectionView.scrollToItem(at: indexpath, at: .left, animated: true)
            questionNumberLabel.text = "\(currentQuestion)"
            
        }
        
        
    }
    
    
    

}

// MARK: API Call to get Data from Data Services

extension PracticeVC {
    
    func getPracticeData() {
        
        data.getPracticeData(url: PRACTICE_URL) { (PracticeElement) in
            
            self.practiceDataArray = PracticeElement
            
            for answersData in self.practiceDataArray {
                
                self.answersDataArray.append(answersData.answer)
                
            }
            
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
            
            createdRowIndexpath = cell.tableView.tag
            
            cell.tableView.delegate = nil
            cell.tableView.dataSource = nil
            
            cell.tableView.delegate = self
            cell.tableView.dataSource = self
        
            cell.tableView.reloadData()
            
            shouldSelectRightAnswer = false
            
            previousButton.isHidden = cell.tableView.tag == 0 ? true : false
            nextButton.isHidden = cell.tableView.tag == practiceDataArray.count - 1 ? true : false
            
            currentQuestion = cell.tableView.tag + 1
            questionNumberLabel.text = "\(currentQuestion)"
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width), height: 600)
        
    }
    
    
}

// MARK: Practice Table View Implementation

extension PracticeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let practice = self.practiceDataArray[tableView.tag]
        rightAnswer = answersDataArray[tableView.tag]

        if indexPath.row == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeQuestionCell") as! PracticeQuestionCell

            cell.setupView(practice: practice)

            return cell
        }
        else {

            let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeOptionCell") as! PracticeOptionCell

            if indexPath.row == 1 {
                cell.optionLbl.text = "1. " + practice.option1
                cell.optionLbl.backgroundColor = UIColor.clear
            }
            else if indexPath.row == 2 {
                cell.optionLbl.text = "2. " + practice.option2
                cell.optionLbl.backgroundColor = UIColor.clear
            }else {
                cell.optionLbl.text = "3. " + practice.option3
                cell.optionLbl.backgroundColor = UIColor.clear
            }
            

            if shouldSelectRightAnswer {

                if indexPath.row == Int(rightAnswer) {

                    cell.optionLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                } else if indexPath.row == selectedAnswer {

                    cell.optionLbl.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)

                } else {

                    cell.optionLbl.backgroundColor = UIColor.clear

                }

            } 

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !shouldSelectRightAnswer {

            selectedAnswer = indexPath.row
            shouldSelectRightAnswer = true
            tableView.reloadData()
        }
        
        
    }
    
    
}
