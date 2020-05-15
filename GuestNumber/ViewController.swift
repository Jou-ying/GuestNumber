//
//  ViewController.swift
//  GuestNumber
//
//  Created by zoeli on 2020/5/13.
//  Copyright © 2020 zoeli. All rights reserved.
//

//DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {}

import UIKit

class ViewController: UIViewController {
    
    // 目前喊到的數字
    @IBOutlet weak var currentNumber: UILabel!
    
    // 每個人喊數字的視窗和文字區塊
    @IBOutlet var selectedNumberViewList: [UIView]!
    
    @IBOutlet weak var showSelectedNumberView_1: UIView!
    @IBOutlet weak var showSelectedNumberView_2: UIView!
    @IBOutlet weak var showSelectedNumberView_3: UIView!
    @IBOutlet weak var showSelectedNumberView_4: UIView!
    @IBOutlet weak var showSelectedNumberView_5: UIView!
    
    @IBOutlet var selectedNumberLabelList: [UILabel]!

    @IBOutlet weak var showSelectedNumberLabel_1: UILabel!
    @IBOutlet weak var showSelectedNumberLabel_2: UILabel!
    @IBOutlet weak var showSelectedNumberLabel_3: UILabel!
    @IBOutlet weak var showSelectedNumberLabel_4: UILabel!
    @IBOutlet weak var showSelectedNumberLabel_5: UILabel!
    

    // 玩家選擇數字區塊
    @IBOutlet weak var selectNumberView_player: UIView!
    @IBOutlet var selectNumberButtonList: [UIButton]!
    
    @IBOutlet weak var selectNumberButton_1: UIButton!
    
    @IBOutlet weak var selectNumberButton_2: UIButton!
    
    @IBOutlet weak var selectNumberButton_3: UIButton!
    
    
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    
    // 重新按鈕
    @IBOutlet weak var resetButton: UIButton!
    // 開始按鈕
    @IBOutlet weak var startButton: UIButton!
    
    
    @IBOutlet weak var gameOverView: UIView!
    
    
    // 紀錄玩家當前三個選項的狀態
    var selectButtonStatusList = [false, false, false]
    
    // 目前顯示到哪一個人
    var showPlayerNum = 0

    var answerNum = Int.random(in: 50...100)
    
    var currentNum: Int = 0
    
    var isFinished = false
    
    var isDidPass = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 預設初始畫面
        self.defaultValue()
        
        
        // 調整元件樣式
        self.resetButton.layer.borderWidth = 3
        self.resetButton.layer.borderColor = UIColor(red: 94/255.0, green: 163/255.0, blue: 252/255.0, alpha: 1).cgColor
        self.resetButton.layer.cornerRadius = self.resetButton.frame.height / 2
        
        self.startButton.layer.borderWidth = 3
        self.startButton.layer.borderColor = UIColor(red: 94/255.0, green: 163/255.0, blue: 252/255.0, alpha: 1).cgColor
        self.startButton.layer.cornerRadius = self.startButton.frame.height / 2
        
        self.passButton.layer.cornerRadius = self.passButton.frame.height / 2
        
        
        for button in self.selectNumberButtonList {
            
            button.layer.cornerRadius = button.frame.height / 2
            
        }
        
        
    }
    
    
    //MARK: - cust func
    
    // 初始畫面
    func defaultValue() {
        
        self.currentNum = 0
        
        self.currentNumber.text = "\(self.currentNum)"
        
        
        self.startButton.isHidden = !self.resetButton.isHidden
        self.resetButton.isHidden = !self.startButton.isHidden
        
        for selectedNumberView in selectedNumberViewList {
            
            selectedNumberView.isHidden = true
        }
                
        
        self.selectNumberView_player.isHidden = true
        self.gameOverView.isHidden = true
        
        self.isFinished = false
        
        self.passButton.backgroundColor = UIColor.white
        self.passButton.layer.borderColor = UIColor.orange.cgColor
        self.passButton.layer.borderWidth = 3

        self.passButton.isEnabled = true
        
        self.isDidPass = false
        
    }
    
    
    //
    func showPlayerSelectedNum(player: Int) {
                
        // 記錄目前是第幾位
        self.showPlayerNum = player
        
        // 用亂數來執行每個人喊幾個數字
        var selectedCount = Int.random(in: 1...3)
        
        
        for view in self.selectedNumberViewList {
        
            if view.tag != showPlayerNum {
                view.isHidden = true
            }
        }
        
        
        if player == 1 {
            
            self.showSelectedNumberView_1.isHidden = false
            
            for i in 1...selectedCount {
                
                print("player: \(player), selectedCount: \(selectedCount)")
                
                // 判斷是否為每回合的最後一個
                if i == selectedCount {
                    self.isFinished = true
                }
                                
                if i == 1 {
                    
                    self.showSelectedNumberLabel_1.text = "\(self.currentNum+1)"
                    
                }else if i == 2 || i == 3 {
                    
                    self.showSelectedNumberLabel_1.text! += ",\(self.currentNum+1)"
                    
                }
                
                self.currentNum += 1
            }
            
            self.judgeCurrentNumIsAnswer()

            
        }else if player == 2 {
            
            self.showSelectedNumberView_2.isHidden = false
            
            for i in 1...selectedCount {
                
                print("player: \(player), selectedCount: \(selectedCount)")

                
                // 判斷是否為每回合的最後一個
                if i == selectedCount {
                    self.isFinished = true
                }
                                
                if i == 1 {
                    
                    self.showSelectedNumberLabel_2.text = "\(self.currentNum+1)"
                    
                }else if i == 2 || i == 3 {
                    
                    self.showSelectedNumberLabel_2.text! += ",\(self.currentNum+1)"
                    
                }
                
                self.currentNum += 1
            }
            
            self.judgeCurrentNumIsAnswer()

            
        }else if player == 3 {
            
            print("player: \(player)")

            self.selectButtonStatusList = [false, false, false]
            
            self.selectNumberButton_1.setTitle("\(self.currentNum + 1)", for: .normal)
            self.selectNumberButton_1.backgroundColor = UIColor(red: 94/255.0, green: 163/255.0, blue: 252/255.0, alpha: 1)
            
            self.selectNumberButton_2.setTitle("\(self.currentNum + 2)", for: .normal)
            self.selectNumberButton_2.backgroundColor = UIColor(red: 94/255.0, green: 163/255.0, blue: 252/255.0, alpha: 1)
            
            self.selectNumberButton_3.setTitle("\(self.currentNum + 3)", for: .normal)
            self.selectNumberButton_3.backgroundColor = UIColor(red: 94/255.0, green: 163/255.0, blue: 252/255.0, alpha: 1)
            
            self.selectNumberView_player.isHidden = false
            
            
        }else if player == 4 {
            
            self.showSelectedNumberView_4.isHidden = false
            
            for i in 1...selectedCount {
                
                print("player: \(player), selectedCount: \(selectedCount)")

                
                // 判斷是否為每回合的最後一個
                if i == selectedCount {
                    self.isFinished = true
                }
                                
                if i == 1 {
                    
                    self.showSelectedNumberLabel_4.text = "\(self.currentNum+1)"
                    
                }else if i == 2 || i == 3 {
                    
                    self.showSelectedNumberLabel_4.text! += ",\(self.currentNum+1)"
                    
                }
                
                self.currentNum += 1
            }
            
            self.judgeCurrentNumIsAnswer()
            
            
        }else if player == 5 {
            
            self.showSelectedNumberView_5.isHidden = false
            
            for i in 1...selectedCount {
                
                print("player: \(player), selectedCount: \(selectedCount)")

                
                // 判斷是否為每回合的最後一個
                if (i == (selectedCount-1)) {
                    self.isFinished = true
                }
                
                if i == 1 {
                    
                    self.showSelectedNumberLabel_5.text = "\(self.currentNum+1)"
                    
                }else if i == 2 || i == 3 {
                    
                    self.showSelectedNumberLabel_5.text! += ",\(self.currentNum+1)"
                    
                }
                
                self.currentNum += 1
                                
            }
            
            self.judgeCurrentNumIsAnswer()
            
        }
    }
    
    
    // 判斷當前數字是否吻合(當前數值(currentNum)變動就會執行)
    func judgeCurrentNumIsAnswer() {
        
        print("檢核答案")
        
        self.currentNumber.text = "\(self.currentNum)"
                  
        if currentNum >= self.answerNum {
               
            self.gameOverView.isHidden = false
                      
        }else {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                
                if self.showPlayerNum != 5 {
                    
                    //換下一位
                    self.showPlayerSelectedNum(player: self.showPlayerNum + 1)
                    
                }else {
                    
                    //目前已經到第五位結束一回合，故從第一位再次開始
                    self.showPlayerNum = 1
                    self.showPlayerSelectedNum(player: 1)
                    
                }
                
                
            }
        }
    }
       
    
    
    //MARK: - IBACtion
    
    // 點擊開始按鈕
    @IBAction func didTapStartButton(_ sender: UIButton) {
        
        self.startButton.isHidden = true
        self.resetButton.isHidden = false
        self.showPlayerNum = 0
        self.showPlayerSelectedNum(player: 1)
        
    }
    

    @IBAction func didTapResetButton(_ sender: UIButton) {
        
        self.resetButton.isHidden = true
        self.startButton.isHidden = false
        
        // 恢復預設值
        self.defaultValue()
    }
    

    // 點選完數字後送出選項
    @IBAction func didTapSendButtom(_ sender: UIButton) {
    
        self.selectNumberView_player.isHidden = true
        
        
        var count = 0
        // 判斷選項的狀態確認玩家選擇了幾個數字
        for i in 0..<self.selectNumberButtonList.count {
            
            if self.selectButtonStatusList[i] {
                
                if i == self.selectNumberButtonList.count - 1 {
                    self.isFinished = true
                }
                
                count += 1
                
            }
        }
        
        
        self.currentNum += count
        self.judgeCurrentNumIsAnswer()
    }
    
    
    // 點選數字按鈕
    @IBAction func didTapSelectNumberButton(_ sender: UIButton) {
        
        let button = sender
        let buttonTag = sender.tag
        
        // 更改目前選項的狀態
        self.selectButtonStatusList[buttonTag] = !self.selectButtonStatusList[buttonTag]
        
        // 依照狀態改變button的顏色
        if self.selectButtonStatusList[buttonTag] {
            
            button.backgroundColor = UIColor.gray
        
        }else {
            
            button.backgroundColor = UIColor(red: 94/255.0, green: 163/255.0, blue: 252/255.0, alpha: 1)
            
        }
    }
    
    
    // 選擇pass此回合
    @IBAction func didTapPassButton(_ sender: Any) {
        
        self.isDidPass = true
        
        self.passButton.backgroundColor = UIColor.gray
        self.passButton.layer.borderWidth = 0
        self.passButton.titleLabel?.textColor = UIColor.white
        self.passButton.isEnabled = false
        
        self.selectNumberView_player.isHidden = true
        
//        sleep(2)
        self.showPlayerSelectedNum(player: 4)

    }
    
}

