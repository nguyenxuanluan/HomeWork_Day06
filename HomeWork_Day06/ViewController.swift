//
//  ViewController.swift
//  HomeWork_Day06
//
//  Created by LuanNX on 1/16/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myScore: UILabel!
    @IBOutlet weak var highScoreTxt: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var playButton: UIButton!
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
        // Do any additional setup after loading the view, typically from a nib.
       
        
        
     
    }
    @IBAction func playGame(_ sender: Any) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


