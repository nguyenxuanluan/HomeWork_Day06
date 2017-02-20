//
//  PlayGameViewController.swift
//  HomeWork_Day06
//
//  Created by LuanNX on 1/16/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {
    let NUM_OF_POKEMON = 721
    let TIME_PLAY = 40
    @IBOutlet weak var myPokemonLabel: UILabel!
        @IBOutlet weak var answerA: UIButton!
     var arr:[Int] = []
    var rand:Int!
    var rightAnswer:String!
    var rightButton:UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var backImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    var labelOrigin:CGPoint!
    var imageView: UIImageView!
    @IBOutlet weak var answerD: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerB: UIButton!
    var changeQuesTimer:Timer!
    var isFirstTime = true
    var genArr: [Bool] = [Bool]()
    override func viewDidLoad() {
        super.viewDidLoad()
        boundButton()
        labelOrigin = myPokemonLabel.frame.origin
        timeLabel.text = "\(TIME_PLAY)"
        loadData()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: self, repeats: true)
        
    }
   
    @IBAction func touchAnswerA(_ sender: UIButton) {
        whenTouchButton(sender: sender,answerButton: answerA)
    }
    
    @IBAction func touchAnswerB(_ sender: UIButton) {
        whenTouchButton(sender: sender,answerButton: answerB)
    }
    @IBAction func touchAnswerC(_ sender: UIButton) {
        whenTouchButton(sender: sender,answerButton: answerC)
    }
    
    @IBAction func touchAnswerD(_ sender: UIButton) {
        whenTouchButton(sender: sender,answerButton: answerD)
    }
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateTime(mytimer: Timer){
        var time = NumberFormatter().number(from: timeLabel.text!) as! Int
        if time == 0{
            mytimer.invalidate()
            alert()
        } else {
        time -= 1
        }
        timeLabel.text = "\(time)"
    }
    func alert(){
        let score = NumberFormatter().number(from: scoreLabel.text!) as! Int
        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        let alert = UIAlertController(title: "Time's up", message: "Your score : \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            
            if score > highScore {
                UserDefaults.standard.set(score, forKey: "highScore")
            }
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func loadData() {
        
        
        var answer:[Int] =  []// contains number from 0 to 3 to set right and wrong answer
        myPokemonLabel.isHidden = true
        var temp:Int!
        // Get the random number from 0 to NUM_OF_POKEMON-1
        rand = randExcept(arr: arr, limit: NUM_OF_POKEMON)
        arr.append(rand)
        print(arr.count)
        //var newArr = arr
        //newArr.append(rand)
        // set data for stage by below number
        let database = DataBaseManager()
        let rs = database.getPokemonById(id: rand)
        setupImage(imageName: rs.img)
        self.view.backgroundColor = UIColor().hexStringToUIColor(hex: rs.color)
        if !isFirstTime{
        
        imageView.frame.origin = CGPoint(x: self.view.frame.width, y: 20)
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveLinear, animations: {
            self.imageView.frame.origin = CGPoint(x: 5, y: 20)
        }, completion:{
            (completion) in
            self.initButton()
        })
        } else {
            isFirstTime = false
        }
        // set right answer in A or B or C or D
        let right = randExcept(arr: [], limit: 4)
        setAnswer(rand: right, answer: rs.name)
        rightAnswer = rs.name
        getRightButton(rand: right)
        answer.append(right)
        //
        var tempArr:[Int] = [rand]
        for i in 0...2 {
            temp = randExcept(arr: answer, limit: 4)
            answer.append(temp)
            let otherRand = randExcept(arr: tempArr, limit: NUM_OF_POKEMON)
            tempArr.append(otherRand)
            print("\(temp) , \(otherRand)")
            print("-----------------")
            setAnswer(rand: answer[i+1], answer: DataBaseManager().getPokemonById(id: otherRand).name)
        }
    }
    
    func animation(tag: String,name:String){
        UIView.transition(from: imageView, to: backImageView, duration: 1, options: .transitionFlipFromRight, completion: {
            (completion) in
            self.myPokemonLabel.text = "\(tag)  \(name)"
            self.myPokemonLabel.isHidden = false
        })
        
    }
    
    func whenTouchButton(sender: UIButton,answerButton: UIButton){
        print(rightAnswer)
        
        if !self.checkAnswer(text: sender.titleLabel!.text!){
            answerButton.backgroundColor = UIColor.red
            self.rightButton.backgroundColor = UIColor.green
            
            
        } else {
            answerButton.backgroundColor = UIColor.green
            var temp = NumberFormatter().number(from: self.scoreLabel.text!) as! Int
            temp += 1
            self.scoreLabel.text = "\(temp)"
            
        }
        
        
        let rs = DataBaseManager().getPokemonById(id: rand)
        imageView.image = UIImage(named: rs.name)
        
        self.animation(tag: rs.tag, name: rs.name)
        
        UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveLinear, animations: {
            self.HiddenButton(state: true)
        }, completion: {
            (completion) in
            let oldOrigin = self.backImageView.frame.origin
            
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveLinear, animations: {
                self.myPokemonLabel.frame.origin = CGPoint(x: self.labelOrigin.x-300, y: self.labelOrigin.y)
                self.backImageView.frame.origin = CGPoint(x: oldOrigin.x-300, y: oldOrigin.y)
                
            }, completion: {
                (completion) in
                self.loadData()
            })
            
        })
        
        
    }
    func setupImage(imageName: String) {
        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: containerView.frame.width,  height: containerView.frame.height )))
        imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.backgroundColor = UIColor.white
        backImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: containerView.frame.width , height: containerView.frame.height )))
        backImageView.image = UIImage(named: imageName)
        backImageView.backgroundColor = UIColor.white
        containerView.subviews.forEach {
            $0.removeFromSuperview()
        }
        containerView.addSubview(imageView)
    }

    func boundButton(){
        answerA.layer.cornerRadius = 5
        answerA.layer.masksToBounds = true
        answerB.layer.cornerRadius = 5
        answerB.layer.masksToBounds = true
        answerC.layer.cornerRadius = 5
        answerC.layer.masksToBounds = true
        answerD.layer.cornerRadius = 5
        answerD.layer.masksToBounds = true
    }

    func randExcept(arr: [Int],limit:Int) -> Int{
        
        var check = true
        
        var ran: UInt32 = 0
        while check {
            if limit == NUM_OF_POKEMON{
                ran = arc4random_uniform(UInt32(limit)) + 1
            }
            else { ran = arc4random_uniform(UInt32(limit)) }
            if arr.isEmpty {
                return Int(ran)
            }else{
            for i in 0...arr.count-1{
                if ran == UInt32(arr[i]) {
                    break
                }
                if(i==arr.count-1 && ran != UInt32(arr[i])){
                    check = false
                }
            }
            }
            
        }
        return Int(ran)
    }
    func setAnswer(rand: Int,answer:String){
        switch rand {
        case 0:
            answerA.setTitle(answer, for: .normal)
            
        case 1:
            answerB.setTitle(answer, for: .normal)
            
        case 2:
            answerC.setTitle(answer, for: .normal)
            
        case 3:
            answerD.setTitle(answer, for: .normal)
            
        default: break;
        }
    }
    func getRightButton(rand: Int){
        switch rand {
        case 0:
            rightButton = answerA
            
        case 1:
            rightButton = answerB
            
        case 2:
            rightButton = answerC
            
        case 3:
            rightButton = answerD
            
        default: break;
        }
    }

    func checkAnswer(text:String) -> Bool{
        return text == rightAnswer
    }
        func HiddenButton(state: Bool){
        if state==true {
            answerA.alpha = 0
            answerB.alpha = 0
            
            answerC.alpha = 0
            
            answerD.alpha = 0
        } else {
            answerA.alpha = 1
            answerB.alpha = 1
        
            answerC.alpha = 1
            
            answerD.alpha = 1
        }
        

    }
    func setDefaultButton(){
        
        answerA.backgroundColor = UIColor.white
        answerB.backgroundColor = UIColor.white
        answerC.backgroundColor = UIColor.white
        answerD.backgroundColor = UIColor.white
        
    }
    func initButton(){
        setDefaultButton()
        HiddenButton(state: false)
        myPokemonLabel.frame.origin = labelOrigin
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let rootView = self.navigationController?.viewControllers[0] as! ViewController
        rootView.delegate = self
    }

}
protocol Share:class {
    func myScore() -> Int
}
extension PlayGameViewController:Share{
     func myScore() -> Int {
        return NumberFormatter().number(from: scoreLabel.text!) as! Int
    }

    
}
