//
//  ViewController.swift
//  Tip Caculator
//
//  Created by Alan Lee on 8/9/17.
//  Copyright © 2017 Alan Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var firstTime = true
    
    var tipPercentages = [Double]() //decimal value of tip percentages
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //sets the title (tip percentaage) of a segment in the UISegmentedControl
    func setTipPercentage(control: UISegmentedControl, percentage: Int, segmentIndex: Int) {
        
        control.setTitle(String(percentage)+"%", forSegmentAt: segmentIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //retrive saved data
        let defaults = UserDefaults.standard
        var tip1 = defaults.integer(forKey: "tip1")
        var tip2 = defaults.integer(forKey: "tip2")
        var tip3 = defaults.integer(forKey: "tip3")
        let defaultIdx = defaults.integer(forKey: "default")
        let lastDate = defaults.object(forKey: "lastUsedTime") as? Date ?? Date.distantPast
        let billStr = defaults.string(forKey: "bill")
        
        //fallback to default values if no saved data
        if tip1 == 0 { tip1 = 18 }
        if tip2 == 0 { tip2 = 20 }
        if tip3 == 0 { tip3 = 22 }
        
        tipPercentages = [Double(tip1)*0.01, Double(tip2)*0.01, Double(tip3)*0.01]
        
        setTipPercentage(control: tipControl, percentage: tip1, segmentIndex: 0)
        setTipPercentage(control: tipControl, percentage: tip2, segmentIndex: 1)
        setTipPercentage(control: tipControl, percentage: tip3, segmentIndex: 2)
        
        //set the default only when the app is first loaded
        if firstTime {
            tipControl.selectedSegmentIndex = defaultIdx
            firstTime = false
        }
        
        //if starting again in 10 mins, use saved bill
        let cacheClearInterval = 60.0 * 10
        if Date() < (lastDate + cacheClearInterval) {
            billField.text = billStr
        }
        
        billField.becomeFirstResponder()
        updateTip(billField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func updateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        let defaults = UserDefaults.standard
        defaults.set(billField.text, forKey: "bill")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

