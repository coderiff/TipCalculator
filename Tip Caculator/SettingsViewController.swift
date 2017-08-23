//
//  SettingsViewController.swift
//  Tip Caculator
//
//  Created by Alan Lee on 8/14/17.
//  Copyright © 2017 Alan Lee. All rights reserved.
//

import UIKit
//import Foundation

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var defaultControl: UISegmentedControl!

    @IBOutlet weak var stepper: UIStepper!
    
    //sets the title (tip percentage) of a segment in the UISegmentedControl
    func setTipPercentage(control: UISegmentedControl, percentage: Int, segmentIndex: Int) {
        
        control.setTitle(String(percentage)+"%", forSegmentAt: segmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retrive saved data
        let defaults = UserDefaults.standard
        var tip1 = defaults.integer(forKey: "tip1")
        var tip2 = defaults.integer(forKey: "tip2")
        var tip3 = defaults.integer(forKey: "tip3")
        let defaultIdx = defaults.integer(forKey: "default")

        //fallback to default values if no saved data
        if tip1 == 0 { tip1 = 18 }
        if tip2 == 0 { tip2 = 20 }
        if tip3 == 0 { tip3 = 22 }
        
        setTipPercentage(control: tipControl, percentage: tip1, segmentIndex: 0)
        setTipPercentage(control: tipControl, percentage: tip2, segmentIndex: 1)
        setTipPercentage(control: tipControl, percentage: tip3, segmentIndex: 2)
        
        setTipPercentage(control: defaultControl, percentage: tip1, segmentIndex: 0)
        setTipPercentage(control: defaultControl, percentage: tip2, segmentIndex: 1)
        setTipPercentage(control: defaultControl, percentage: tip3, segmentIndex: 2)
        
//        tipControl.setTitle(String(tip1)+"%", forSegmentAt: 0)
//        tipControl.setTitle(String(tip2)+"%", forSegmentAt: 1)
//        tipControl.setTitle(String(tip3)+"%", forSegmentAt: 2)
//
//        defaultControl.setTitle(String(tip1)+"%", forSegmentAt: 0)
//        defaultControl.setTitle(String(tip2)+"%", forSegmentAt: 1)
//        defaultControl.setTitle(String(tip3)+"%", forSegmentAt: 2)
        
        defaultControl.selectedSegmentIndex = defaultIdx
        
        //set cutomizable tip fields with the saved value
        onSegmentValueChanged(tipControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        //save tip percentage data
        let defaults = UserDefaults.standard
        
        var title1 = tipControl.titleForSegment(at: 0)!
        title1.remove(at: title1.index(before: title1.endIndex))
        
        var title2 = tipControl.titleForSegment(at: 1)!
        title2.remove(at: title2.index(before: title2.endIndex))
        
        var title3 = tipControl.titleForSegment(at: 2)!
        title3.remove(at: title3.index(before: title3.endIndex))
        
        let defaultIdx = defaultControl.selectedSegmentIndex
        
        defaults.set(Int(title1), forKey: "tip1")
        defaults.set(Int(title2), forKey: "tip2")
        defaults.set(Int(title3), forKey: "tip3")
        defaults.set(defaultIdx, forKey: "default")
        defaults.synchronize()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    @IBAction func onSegmentValueChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        var title = sender.titleForSegment(at: index)!
        title.remove(at: title.index(before: title.endIndex))
        stepper.value = Double(title)!
    }

    @IBAction func onStepperChanged(_ sender: UIStepper) {
        let percentage = Int(sender.value).description + "%"
        tipControl.setTitle(percentage, forSegmentAt: tipControl.selectedSegmentIndex)
        defaultControl.setTitle(percentage, forSegmentAt: tipControl.selectedSegmentIndex)
    }
    
 }
