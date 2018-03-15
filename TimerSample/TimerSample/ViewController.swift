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
    
    let PERIOD_TIME = 600
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
        // -1秒したところからカウントダウンする
        if resetFlag == true {
            time -= 1
        } else {
            resetFlag = false
        }
        // 00:00までのカウントダウンタイマー
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
        //00:00用カウントダウンタイマーの登録
        RunLoop.main.add(self.timer!, forMode: .defaultRunLoopMode)
        
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
        self.timer?.invalidate()
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
    
    
    /// 1秒ごとに動作するタイマー
    @objc func timerUpdate() {
        time -= 1

        if time < 0 {
            self.timer?.invalidate()
        } else {
            showTimeImage(srcTime: time)
        }
    }
    
    /// ミリ秒ごとに動作するタイマー
    @objc func miliTimerUpdate() {
        imgMilisecond.image = digi[milisecond]
        milisecond -= 1
        if milisecond < 0 {
            milisecond = 9
        } else {
            return
        }
    }
    
    
    /// 指定した秒数を画像で表示する
    ///
    /// - Parameter srcTime: 秒数
    func showTimeImage(srcTime : Int) {
        labelTime.text = String(time)
        let imgTime = getTime(srcTime: time)
        img10min.image = digi[imgTime.0]
        img1min.image = digi[imgTime.1]
        img10sec.image = digi[imgTime.2]
        img1sec.image = digi[imgTime.3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// 指定した秒を10分、1分、60秒、1秒に分割して返却する
    ///
    /// - Returns:
    func getTime(srcTime : Int) -> (Int,Int,Int,Int) {
        //10分
        var ans10min = 0
        if srcTime >= 600 {
            ans10min = srcTime / 600
        }
        //1分
        var ans1min = 0
        if srcTime >= 60 {
            ans1min = (srcTime - (ans10min * 600)) / 60
        }
        //10秒
        var ans10sec = 0
        if srcTime >= 10 {
            ans10sec = (srcTime - (ans10min * 600 + ans1min * 60)) / 10
        }
        //1秒
        let ans1sec = (srcTime - (ans10min * 600 + ans1min * 60 + ans10sec * 10))
        
        return (ans10min, ans1min, ans10sec, ans1sec)
    }

}

