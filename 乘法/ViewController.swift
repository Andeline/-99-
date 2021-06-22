//
//  ViewController.swift
//  乘法
//
//  Created by 蔡佳穎 on 2021/6/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var player1View: UIView!
    @IBOutlet weak var player1QLabel: UILabel!
    @IBOutlet weak var player2QLabel:
        UILabel!
    @IBOutlet var player1Btns: [UIButton]!
    @IBOutlet var player2Btns: [UIButton]!
    
    @IBOutlet weak var turtleImageView: UIImageView!
    @IBOutlet weak var rabbitImageView: UIImageView!

    var leftNums = [Int]()
    var rightNums = [Int]()
    var answers = [Int]()
    var player1Index = 0
    var player2Index = 0
    var player1CorrectIndex = 0
    var player2CorrectIndex = 0
    
    func creatQA() {
        var leftNum = 0
        var rightNum = 0
        var answer = 0
        for i in 0...19 {
            leftNum = Int.random(in: 1...9)
            rightNum = Int.random(in: 1...9)
            leftNums.append(leftNum)
            rightNums.append(rightNum)
            
            //如果前後兩題重複，重新出題
            if i > 0 && i < 20 {
                while leftNums[i] == leftNums[i-1] && rightNums[i] == rightNums[i-1] {
                    leftNums.removeLast()
                    rightNums.removeLast()
                    leftNum = Int.random(in: 1...9)
                    rightNum = Int.random(in: 1...9)
                    leftNums.append(leftNum)
                    rightNums.append(rightNum)
                }
            }
            answer = leftNum * rightNum
            answers.append(answer)
        }
    }
    
    func showPlayer1QA() {
        player1QLabel.text = "\(leftNums[player1Index]) × \(rightNums[player1Index])"
        player1QLabel.sizeToFit()
        var options = [answers[player1Index], answers[player1Index]+1, answers[player1Index]-1, answers[player1Index]+10]
        options.shuffle()
        for i in 0...3 {
            player1Btns[i].setTitle("\(options[i])", for: .normal)
        }
    }
    
    func showPlayer2QA() {
        player2QLabel.text = "\(leftNums[player2Index]) × \(rightNums[player2Index])"
        player2QLabel.sizeToFit()
        var options = [answers[player2Index], answers[player2Index]+1, answers[player2Index]-1, answers[player2Index]+10]
        options.shuffle()
        for i in 0...3 {
            player2Btns[i].setTitle("\(options[i])", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oneDegree = CGFloat.pi / 180
        player1View.transform = CGAffineTransform.identity.rotated(by: oneDegree * 180)
        creatQA()
        showPlayer1QA()
        showPlayer2QA()
        player1Index += 1
        player2Index += 1
    }
    
    func winAlert(winner: String, loser: String) {
        let controller = UIAlertController(title: "\(winner)獲勝！", message: "\(loser)想扳回一城嗎？", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "yes", style: .default) { [self]_ in
            self.player1Index = 0
            self.player2Index = 0
            self.player1CorrectIndex = 0
            self.player2CorrectIndex = 0
            self.creatQA()
            player1Index += 1
            player2Index += 1
            self.showPlayer1QA()
            self.showPlayer2QA()
            turtleImageView.transform = CGAffineTransform(translationX: 0, y: 0)
            rabbitImageView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        controller.addAction(yesAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func player1SelectAnswer(_ sender: UIButton) {
        if player1CorrectIndex < 6 {
            if sender.currentTitle == "\(answers[player1Index-1])" {
                player1CorrectIndex += 1
                turtleImageView.transform = CGAffineTransform(translationX: CGFloat(-109 * player1CorrectIndex), y: 0)
                //下一題
                showPlayer1QA()
                player1Index += 1
            } else {
                //下一題
                showPlayer1QA()
                player1Index += 1
            }
            //獲勝
            if player1CorrectIndex == 6 {
                winAlert(winner: "烏龜", loser: "兔子")
            }
        }
    }
    
    @IBAction func player2SelectAnswer(_ sender: UIButton) {
        if player2CorrectIndex < 6 {
            if sender.currentTitle == "\(answers[player2Index-1])" {
                player2CorrectIndex += 1
                rabbitImageView.transform = CGAffineTransform(translationX: CGFloat(-109 * player2CorrectIndex), y: 0)
                //下一題
                showPlayer2QA()
                player2Index += 1
            } else {
                //下一題
                showPlayer2QA()
                player2Index += 1
            }
            //獲勝
            if player2CorrectIndex == 6 {
                winAlert(winner: "兔子", loser: "烏龜")
            }
        }
    }
}

