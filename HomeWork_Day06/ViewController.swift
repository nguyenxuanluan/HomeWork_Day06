//
//  ViewController.swift
//  HomeWork_Day06
//
//  Created by LuanNX on 1/16/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class ViewController: UIViewController {
    @IBOutlet weak var myScore: UILabel!
    @IBOutlet weak var highScoreTxt: UILabel!
    @IBOutlet weak var highScore: UILabel!
    weak var delegate:Share?
    var status = true
    override func viewWillAppear(_ animated: Bool) {
        if  let score = delegate?.myScore() {
            myScore.text = "\(score)"
            myScore.isHidden = false
            highScore.isHidden = false
            highScoreTxt.isHidden = false
            highScore.text = "\(UserDefaults.standard.integer(forKey: "highScore"))"
        } else {
            myScore.isHidden = true
            highScore.isHidden = true
            highScoreTxt.isHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBaseManager.copyDatabase()
        var introMusic : AVAudioPlayer!
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "8-Bit-Mayhem", ofType: "wav")!) 
        do {
        introMusic = try AVAudioPlayer(contentsOf: url)
            print("OK")
        } catch {
            print("Can't play")
        }
        //introMusic.numberOfLoops = -1
        print(introMusic.prepareToPlay())
        introMusic.play()
        print(introMusic.isPlaying)
        
        // Do any additional setup after loading the view, typically from a nib.
       
        
        
     
    }
    @IBAction func playGame(_ sender: Any) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


