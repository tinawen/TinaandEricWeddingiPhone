//
//  BigDayViewController.swift
//  TinaAndEricWedding
//
//  Created by tina on 6/14/15.
//  Copyright (c) 2015 tina. All rights reserved.
//

import UIKit

class BigDayViewController: UIViewController {
    var calendar: NSCalendar?
    var timer: NSTimer?
    var bigDayArrived: Bool = false

    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var daysRightLabel: UILabel!
    
    @IBOutlet weak var minsLeftLabel: UILabel!
    
    @IBOutlet weak var minsRightLabel: UILabel!
    
    @IBOutlet weak var secsLeftLabel: UILabel!

    @IBOutlet weak var secsRightLabel: UILabel!
    
    @IBOutlet weak var bigDayArrivedLabel: UILabel!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTimeRemainingToBigDay()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updateTimeRemainingToBigDay", userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
        self.timer = nil
    }
    
    func updateTimeRemainingToBigDay() {
        if bigDayArrived {
            timer?.invalidate()
            timer = nil
        }
        let bigDay = DateHelper.weddingDate()
        let curDay = NSDate()
        if calendar == nil {
            calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        }
        
        let secComponents = calendar?.components(.CalendarUnitSecond, fromDate: curDay, toDate: bigDay, options: .WrapComponents)
        let secComponent = secComponents!.second
        if secComponent > 0 {
            let days = secComponent / (60 * 60 * 24)
            let daysLeftNumber: Int = days % 100 / 10
            daysLeftLabel.text = String(daysLeftNumber)
            let daysRightNumber: Int = days % 10
            daysRightLabel.text = String(daysRightNumber)
            
            let daysRemainder = secComponent % (60 * 60)
            let mins = daysRemainder / 60
            let minsLeftNumber: Int = mins / 10
            minsLeftLabel.text = String(minsLeftNumber)
            let minsRightNumber: Int = mins % 10
            minsRightLabel.text = String(minsRightNumber)
            
            let secs = daysRemainder % 60
            let secsLeftNumber: Int = secs / 10
                secsLeftLabel.text = String(secsLeftNumber)
            let secsRightNumber: Int = secs % 10
            secsRightLabel.text = String(secsRightNumber)
        } else {
            bigDayArrived = true
            secsLeftLabel.text = "0"
            secsRightLabel.text = "0"
            minsLeftLabel.text = "0"
            minsRightLabel.text = "0"
            daysLeftLabel.text = "0"
            daysRightLabel.text = "0"
        }
        bigDayArrivedLabel.text = bigDayArrived ? "The Big Day Has Arrived!!!" : "Until our big day!"
    }
}
