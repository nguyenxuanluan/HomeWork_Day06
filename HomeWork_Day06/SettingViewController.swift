//
//  SettingViewController.swift
//  HomeWork_Day06
//
//  Created by LuanNX on 2/19/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var EffectState: UISwitch!
    @IBOutlet weak var gen1Button: UIButton!
    @IBOutlet weak var gen2Button: UIButton!
    @IBOutlet weak var gen3Button: UIButton!
    @IBOutlet weak var gen4Button: UIButton!

    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var gen6Button: UIButton!
    @IBOutlet weak var gen5Button: UIButton!
    @IBOutlet weak var musicState: UILabel!
    var stateArr:[Bool] = [true,true,true,true,true,true]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func touchButton1(_ sender: Any) {
        touchButton(button: gen1Button, label: label1, selectedState: stateArr[0])
        stateArr[0] = !stateArr[0]
    }
    @IBAction func touchButton2(_ sender: Any) {
        touchButton(button: gen2Button, label: label2, selectedState: stateArr[1])
        stateArr[1] = !stateArr[1]
    }
    @IBAction func touchButton3(_ sender: Any) {
        touchButton(button: gen3Button, label: label3, selectedState: stateArr[2])
        stateArr[2] = !stateArr[2]
    }
    @IBAction func touchButton4(_ sender: Any) {
        touchButton(button: gen4Button, label: label4, selectedState: stateArr[3])
        stateArr[3] = !stateArr[3]
    }
    @IBAction func touchButton5(_ sender: Any) {
        touchButton(button: gen5Button, label: label5, selectedState: stateArr[4])
        stateArr[4] = !stateArr[4]
    }
    @IBAction func touchButton6(_ sender: Any) {
        touchButton(button: gen6Button, label: label6, selectedState: stateArr[5])
        stateArr[5] = !stateArr[5]
    }
    func touchButton(button:UIButton,label:UILabel,selectedState: Bool){
        if selectedState{
            button.alpha = 0.5
            label.alpha = 0.5
        } else {
            button.alpha = 1
            label.alpha = 1
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
