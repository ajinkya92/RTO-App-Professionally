//
//  ExamVC.swift
//  RTO App Professionally
//
//  Created by Ajinkya Sonar on 01/10/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class ExamVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var rightAnswerIndicatorLabel: UILabel!
    
    @IBOutlet weak var wrongAnswerIndicatorLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    var examData = [Datum]()
    var shuffeledExamData = [Datum]()
    
    // Timer Variables
    
    var countdownTimer: Timer!
    var totalTimeLimit = 30
    
    var createdIndexPath = Int()
    var correctQuestionCounter = 0
    var wrongQuestionCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        getExamData()
        startTimer()
        nextButton.isHidden = false
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        changeToNextQuestion()
        
    }
    
    
    
    
}

// MARK: API Call to get Exam Data

extension ExamVC {
    
    func getExamData() {
        
        ExamDataService.instance.getExamData(url: EXAM_URL) { (examJsonData) in
            
            if let data = examJsonData {
                
                self.examData = data.data
                
                // Get 15 Random Question in the examdata array
                
                for _ in 0...14 {
                    
                    let randomNumberGenerated = Int(arc4random_uniform(UInt32(self.examData.count)))
                    
                    self.shuffeledExamData.append(self.examData[randomNumberGenerated])
                    
                    self.examData.remove(at: randomNumberGenerated)
                    
                }
                
                
            }
            
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
            }
            
        }
        
    }

    
    
}

// MARK: Timer Logic Implementation

extension ExamVC {
    
    func startTimer() {
        
        totalTimeLimit = 30
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ExamVC.updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        
        timerLabel.text = "\(timeFormatted(totalTimeLimit))"
        if totalTimeLimit != 0 {
            totalTimeLimit -= 1
        }
        else {
            endTimer()
            changeToNextQuestion()
        }
        
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
        
    }
    
    func changeToNextQuestion() {
        
        var indexpath = IndexPath(row: createdIndexPath, section: 0)
        
        if createdIndexPath < shuffeledExamData.count - 1 {
            
            createdIndexPath += 1
            indexpath = IndexPath(row: createdIndexPath, section: 0)
            collectionView.scrollToItem(at: indexpath, at: .left, animated: true)
        }
        else {
            nextButton.isHidden = true
            print("Quiz Complete")
        }
        
    }
    
    
}






// MARK: Exam Collection View Implementation

extension ExamVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shuffeledExamData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExamCollectionCell", for: indexPath) as? ExamCollectionCell {
            
            cell.tableView.tag = indexPath.row
            
            createdIndexPath = cell.tableView.tag
            
            cell.tableView.delegate = nil
            cell.tableView.dataSource = nil
            
            cell.tableView.delegate = self
            cell.tableView.dataSource = self
            
            cell.tableView.reloadData()
            
            if indexPath.row <= shuffeledExamData.count - 1 {
                
                if countdownTimer.isValid{
                    
                    countdownTimer.invalidate()
                    
                }
                
                startTimer()
            }
            
            
            
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width, height: self.collectionView.frame.size.height)
        
    }
    
    
    
}

// MARK: Table View Implementation

extension ExamVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let questionData = shuffeledExamData[tableView.tag]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExamQuestionCell") as! ExamQuestionCell
        
        cell.questionLabel.text = "Q." + questionData.question
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let optionData = shuffeledExamData[tableView.tag]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ExamAnswerCell") as? ExamAnswerCell {
            
            if indexPath.row == 0 {
                
                cell.optionLabel.text = "1. " + optionData.option1
                
            }
            else if indexPath.row == 1 {
                cell.optionLabel.text = "2. " + optionData.option2
                
            }
            else {
                cell.optionLabel.text = "3. " + optionData.option3
                
            }
            
            tableView.allowsMultipleSelection = true
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rightAnswers = shuffeledExamData[tableView.tag]

            if indexPath.row + 1 == Int(rightAnswers.answer) {

                correctQuestionCounter += 1
                print("Your Answer is Right")
                rightAnswerIndicatorLabel.text = "\(correctQuestionCounter)"
            }
            else {
                wrongQuestionCounter += 1
                print("Your Answer is Wrong")
                wrongAnswerIndicatorLabel.text = "\(wrongQuestionCounter)"
            }
        
        tableView.allowsSelection = false
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    
    
    
}
