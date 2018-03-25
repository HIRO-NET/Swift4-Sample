//
//  ViewController.swift
//  TimerSample
//
//  Created by 高橋広樹 on 2018/03/14.
//  Copyright © 2018年 HIRO's.NET. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var img10min: UIImageView!
    @IBOutlet weak var img1min: UIImageView!
    @IBOutlet weak var img10sec: UIImageView!
    @IBOutlet weak var img1sec: UIImageView!
    @IBOutlet weak var imgMilisecond: UIImageView!
    
    let ONE_HOUR = 36000
    let ONE_MINUTE = 600
    let ONE_SECOND = 10
    
    let PERIOD_TIME = 6000 // 10分=600Sec
    var timer: Timer?
    var miliTimer: Timer?
    var resetFlag = true
    var time = 0
    var milisecond = 0
    let digi = [UIImage(named:"digi0")!,
                UIImage(named:"digi1")!,
                UIImage(named:"digi2")!,
                UIImage(named:"digi3")!,
                UIImage(named:"digi4")!,
                UIImage(named:"digi5")!,
                UIImage(named:"digi6")!,
                UIImage(named:"digi7")!,
                UIImage(named:"digi8")!,
                UIImage(named:"digi9")!]
    let colon = UIImage(named:"digiColon")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        time = PERIOD_TIME
        labelTime.text = String(PERIOD_TIME)
    }
    
    /// [Start]ボタンタップ処理
    ///
    /// - Parameter sender:
    @IBAction func buttonStart_Tapped(_ sender: Any) {
        // Resetボタンが押された時は、カウントダウンの開始時間がリセットされる
        // リセットされると1秒経ってからカウントダウンが行われるので
        // -0.1秒したところからカウントダウンする
        if resetFlag == true {
            time -= 1
        } else {
            resetFlag = false
        }
//        // 00:00までのカウントダウンタイマー
//        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
//        //00:00用カウントダウンタイマーの登録
//        RunLoop.main.add(self.timer!, forMode: .defaultRunLoopMode)
        
        // ミリ秒のカウントダウンタイマー
        self.miliTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.miliTimerUpdate), userInfo: nil, repeats: true)
        //ミリ秒カウントダウンタイマーの登録
        RunLoop.main.add(self.miliTimer!, forMode: .defaultRunLoopMode)
        

        showTimeImage(srcTime: time)
    }

    /// [Stop]ボタンタップ処理
    ///
    /// - Parameter sender:
    @IBAction func buttonStop_Tapped(_ sender: Any) {
        print("invalidate!!")
        //self.timer?.invalidate()
        self.miliTimer?.invalidate()
    }
    
    
    /// [Reset]ボタンタップ処理
    ///
    /// - Parameter sender:
    @IBAction func buttonReset_Tapped(_ sender: Any) {
        resetFlag = true
        time = PERIOD_TIME
        labelTime.text = String(PERIOD_TIME)
        showTimeImage(srcTime: time)
        imgMilisecond.image = digi[0]
    }
    
    
//    /// 1秒ごとに動作するタイマー
//    @objc func timerUpdate() {
//        time -= 1
//
//        if time < 0 {
//            self.timer?.invalidate()
//        } else {
//            showTimeImage(srcTime: time)
//        }
//    }
    
    /// 100ミリ秒ごとに動作するタイマー
    @objc func miliTimerUpdate() {
//        imgMilisecond.image = digi[milisecond]
//        milisecond -= 1
//        if milisecond < 0 {
//            milisecond = 9
//        } else {
//            return
//        }
        time -= 1   //100mSecを引く

        if time < 0 {
            self.timer?.invalidate()
        } else {
            showTimeImage(srcTime: time)
        }
    }
    
    
    /// 指定した秒数を画像で表示する
    ///
    /// - Parameter srcTime: 秒数
    func showTimeImage(srcTime : Int) {
        labelTime.text = String(time)
        let imgTime = getTime(srcTime: time)
        img10min.image = digi[imgTime.2]
        img1min.image = digi[imgTime.3]
        img10sec.image = digi[imgTime.4]
        img1sec.image = digi[imgTime.5]
        imgMilisecond.image = digi[imgTime.6]
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// 指定した秒を10分、1分、60秒、1秒、1Sec、1mSecに分割して返却する
    ///
    /// - Returns:
    func getTime(srcTime : Int) -> (Int, Int, Int, Int, Int, Int, Int){
        var tempTime = srcTime
        var intHour = 0
        var intMinute = 0
        var intSecond = 0
        
        
        // tempTimeが1時間を超える場合
        if tempTime >= ONE_HOUR {
            intHour = tempTime / ONE_HOUR
            tempTime = tempTime - (intHour * ONE_HOUR)
        }
        let strHour = String(format: "%02d", intHour)
        let intHour1 = Int(strHour[strHour.index(strHour.startIndex, offsetBy: 0)...strHour.index(strHour.startIndex, offsetBy: 0)])
        let intHour2 = Int(strHour[strHour.index(strHour.startIndex, offsetBy: 1)...strHour.index(strHour.startIndex, offsetBy: 1)])
        
        // tempTimeが60秒を超える場合
        if tempTime >= ONE_MINUTE {
            intMinute = tempTime / ONE_MINUTE
            tempTime = tempTime - (intMinute * ONE_MINUTE)
        }
        let strMinute = String(format: "%02d", intMinute)
        let intMinute1 = Int(strMinute[strHour.index(strMinute.startIndex, offsetBy: 0)...strMinute.index(strMinute.startIndex, offsetBy: 0)])
        let intMinute2 = Int(strMinute[strHour.index(strMinute.startIndex, offsetBy: 1)...strMinute.index(strMinute.startIndex, offsetBy: 1)])
        
        // tempTimeが1秒を超える場合
        if tempTime >= ONE_SECOND {
            intSecond = tempTime / ONE_SECOND
            tempTime = tempTime - (intSecond * ONE_SECOND)
        }
        let strSecond = String(format: "%02d", intSecond)
        let intSecond1 = Int(strSecond[strSecond.index(strSecond.startIndex, offsetBy: 0)...strSecond.index(strSecond.startIndex, offsetBy: 0)])
        let intSecond2 = Int(strSecond[strSecond.index(strSecond.startIndex, offsetBy: 1)...strSecond.index(strSecond.startIndex, offsetBy: 1)])
        
        
        print("\(strHour)時間\(strMinute)分\(strSecond).\(tempTime)秒")
        
        return (intHour1!, intHour2!, intMinute1!, intMinute2!, intSecond1!, intSecond2!, Int(tempTime))
    }


}

