//
//  ViewController.swift
//  Calc
//
//  Created by João Eduardo Soares e Silva on 19/02/17.
//  Copyright © 2017 João Eduardo Soares e Silva. All rights reserved.
//

import UIKit

enum modes {
    case NOT_SET
    case ADDITION
    case SUBTRACTION
    case MULTIPLICATION
    case DIVISION
    case PERCENT
    
}

class ViewController: UIViewController {

    var labelString:String = "0"
    var currentMode:modes = modes.NOT_SET
    var savedNum:Float = 0
    var lastBtnWasMode:Bool = false
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tapped0(sender: AnyObject) {tappedNumber(0)}
    @IBAction func tapped1(sender: AnyObject) {tappedNumber(1)}
    @IBAction func tapped2(sender: AnyObject) {tappedNumber(2)}
    @IBAction func tapped3(sender: AnyObject) {tappedNumber(3)}
    @IBAction func tapped4(sender: AnyObject) {tappedNumber(4)}
    @IBAction func tapped5(sender: AnyObject) {tappedNumber(5)}
    @IBAction func tapped6(sender: AnyObject) {tappedNumber(6)}
    @IBAction func tapped7(sender: AnyObject) {tappedNumber(7)}
    @IBAction func tapped8(sender: AnyObject) {tappedNumber(8)}
    @IBAction func tapped9(sender: AnyObject) {tappedNumber(9)}
    
    @IBAction func tappedComa(sender: AnyObject) {
        if lastBtnWasMode {
            lastBtnWasMode = false
            labelString = "0"
        }
        
        
        
        guard let labelFloat:Float = Float(labelString) else{
            label.text = "Conversao de String para Float Falhou"
            return
        }
        
        if labelFloat % 1 != 0 || labelFloat == 0{
            return
        }
        
        
        labelString = labelString.stringByAppendingString(".")
        updateText()
        
    }
    
    
    @IBAction func tappedPlus(sender: AnyObject) {
        changeMode(modes.ADDITION)
    }
    
    @IBAction func tappedMinus(sender: AnyObject) {
        changeMode(modes.SUBTRACTION)
    }
    
    @IBAction func tappedMultiply(sender: AnyObject) {
        changeMode(modes.MULTIPLICATION)
    }
    
    @IBAction func tappedDivision(sender: AnyObject) {
        changeMode(modes.DIVISION)
    }
    
    @IBAction func tappedPercent(sender: AnyObject) {
        changeMode(modes.PERCENT)
    }
    
    @IBAction func tappedInvert(sender: AnyObject) {
        
        guard var labelFloat:Float = Float(labelString) else{
            label.text = "Conversao de String para Float Falhou"
            return
        }
        
        labelFloat *= -1
        
        labelString = "\(labelFloat)"
        updateText()
    }
    
    @IBAction func tappedEquals(sender: AnyObject) {
        guard let num:Float = Float(labelString) else {
            return
        }
        
        if currentMode == modes.NOT_SET || lastBtnWasMode{
            return
        }
        
        if currentMode == modes.ADDITION {
            savedNum += num
        }
        else if currentMode == modes.SUBTRACTION {
            savedNum -= num
        }
        else if currentMode == modes.MULTIPLICATION {
            savedNum *= num
        }
        else if currentMode == modes.DIVISION {
            savedNum /= num
        }
        else if currentMode == modes.PERCENT {
            savedNum = num * (savedNum/100)
        }
        
        currentMode = modes.NOT_SET
        labelString = "\(savedNum)"
        updateText()
        lastBtnWasMode = true
    }
    
    @IBAction func tappedClear(sender: AnyObject) {
        labelString = "0"
        currentMode = modes.NOT_SET
        savedNum = 0
        lastBtnWasMode = false
        label.text = "0"
    }
    
    func tappedNumber(num:Int){
        if lastBtnWasMode {
            lastBtnWasMode = false
            labelString = "0"
        }
        labelString = labelString.stringByAppendingString("\(num)")
        updateText()
    }
    
    
    func updateText(){
        
        
        guard let labelFloat:Float = Float(labelString) else{
            label.text = "Conversao de String para Float Falhou"
            return
        }
        
        if currentMode == modes.NOT_SET {
                savedNum = labelFloat
        }
        
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let num:NSNumber = NSNumber(float: labelFloat)
        
        label.text = formatter.stringFromNumber(num)
    }
    
    func changeMode(newMode:modes){
        if savedNum == 0{
            return
        }
        currentMode = newMode
        lastBtnWasMode = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

