//
//  ViewController.swift
//  Lab03S
//
//  Created by Rui Geng on 2016-09-22.
//  Copyright © 2016 Rui Geng. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var LabSalary: UILabel!
    
    @IBOutlet weak var SliderSalary: UISlider!
    
    @IBOutlet weak var LabSecondSalary: UILabel!
    
    private var annualSalary:Int = 0
    
    private var timer = NSTimer()
    
    private let DAY:Double = 365
    
    private let HOUR:Double = 24
    
    private let MINUTES:Double = 60
    
    private let SECOND:Double = 60
    
    private var secondSalary:Double = 0
    
    private var currentIncome:Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let salaryValue:Float = userDefaults.floatForKey("AnnualSalaryKey")
        {
            SliderSalary.value = salaryValue
        }
        else{
            SliderSalary.value = SliderSalary.minimumValue

        }
        
        if let incomeValue:Double = userDefaults.doubleForKey("CurrentIncomeKey"){
            
            currentIncome = incomeValue

        }
        else{
            
            currentIncome = 0
        }
        
        annualSalary = Int(SliderSalary.value)
        
        LabSalary.text = "Annual Salary: $ \(annualSalary)"
        
        LabSecondSalary.text = String.localizedStringWithFormat("$ %0.4f", currentIncome)
        
        secondSalary = Double(annualSalary)/DAY/HOUR/MINUTES/SECOND
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startTimer(sender: UIButton) {
        
        if(!timer.valid){
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func stopTimer(sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        annualSalary = Int(sender.value)
        LabSalary.text = "Annual Salary: $ \(annualSalary)"
        secondSalary = Double(annualSalary)/DAY/HOUR/MINUTES/SECOND
    }
    
    @IBAction func saveValue(sender: UIButton) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setFloat(SliderSalary.value, forKey: "AnnualSalaryKey")
        
        userDefaults.setDouble(currentIncome, forKey: "CurrentIncomeKey")
    }
    
    func updateCounter() {
        
        currentIncome = currentIncome + secondSalary
        
        LabSecondSalary.text = String.localizedStringWithFormat("$ %0.4f", currentIncome)
    }

}

