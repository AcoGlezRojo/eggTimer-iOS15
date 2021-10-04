//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft" : 10, "Medium": 420, "Hard": 720] //dictionary
    
    var totalTimer = 0
    var secondPassed = 0
    var timer = Timer()
    
    
    let alarm = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    

    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        progressBar.progress = 0.0
        secondPassed = 0
        
        let hardness = sender.currentTitle!
        totalTimer = eggTimes[hardness]!
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
    }
    
    @objc func updateTimer() {
        //timer function
        if secondPassed < totalTimer {
            let pp = Float(secondPassed) / Float(totalTimer)
            progressBar.progress = pp
            secondPassed += 1
        } else {
            timer.invalidate()
            progressBar.progress = 1.0
            titleLabel.text = "DONE!"
            
            player = try! AVAudioPlayer(contentsOf: alarm!)
            player.play()
        }
    }
    
}
