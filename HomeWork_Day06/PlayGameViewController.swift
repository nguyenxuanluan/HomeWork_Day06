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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerD: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerB: UIButton!
    var changeQuesTimer:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
       timeLabel.text = "\(TIME_PLAY)"
        //UserDefaults.standard.set(-1, forKey: "highScore")
        // Do any additional setup after loading the view.
        loadData()
         changeQuesTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(loadData), userInfo: nil, repeats: true)
    
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: self, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateTime(mytimer: Timer){
        var time = NumberFormatter().number(from: timeLabel.text!) as! Int
        if time == 0{
            mytimer.invalidate()
            changeQuesTimer.invalidate()
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
        initButton()
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
        imageView.image = UIImage(named: rs.img)?.withRenderingMode(.alwaysTemplate)
        imageView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor().hexStringToUIColor(hex: rs.color)
        
        // set right answer in A or B or C or D
        let right = randExcept(arr: [], limit: 4)
        print(right)
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
    func checkAnswer(text:String) -> Bool{
        return text == rightAnswer
    }
    func whenTouchButton(sender: UIButton,answerButton: UIButton){
        print(rightAnswer)
        if !checkAnswer(text: sender.titleLabel!.text!){
            answerButton.backgroundColor = UIColor.red
            rightButton.backgroundColor = UIColor.green
            
            
        } else {
            answerButton.backgroundColor = UIColor.green
            var temp = NumberFormatter().number(from: scoreLabel.text!) as! Int
            temp += 1
            scoreLabel.text = "\(temp)"
            
        }
        let rs = DataBaseManager().getPokemonById(id: rand)
        imageView.image = UIImage(named: rs.name)
        myPokemonLabel.isHidden = false
        EnableButton(state: false)
        myPokemonLabel.text = "\(rs.tag)  \(rs.name)"
    }
    func EnableButton(state: Bool){
        answerA.isEnabled = state
        answerB.isEnabled = state

        answerC.isEnabled = state

        answerD.isEnabled = state

    }
    func setDefaultButton(){
        answerA.backgroundColor = UIColor.white
        answerB.backgroundColor = UIColor.white
        answerC.backgroundColor = UIColor.white
        answerD.backgroundColor = UIColor.white
        
    }
    func initButton(){
        EnableButton(state: true)
        setDefaultButton()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        let rootView = self.navigationController?.viewControllers[0] as! ViewController
        rootView.delegate = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
protocol Share:class {
    func myScore() -> Int
}
extension PlayGameViewController:Share{
     func myScore() -> Int {
        return NumberFormatter().number(from: scoreLabel.text!) as! Int
    }

    
}
