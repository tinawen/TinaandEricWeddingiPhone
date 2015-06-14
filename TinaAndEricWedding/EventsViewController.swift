//
//  EventsViewController.swift
//  TinaAndEricWedding
//
//  Created by tina on 6/14/15.
//  Copyright (c) 2015 tina. All rights reserved.
//

import UIKit
import EventKit
import MapKit

class EventsViewController: UIViewController {

    let meadowWoodManorLat = 40.862326
    let meadowWoodManorLong = -74.564723
    let meadowWoodManorName = "Meadow Wood Manor"
    let meadowWoodManorURL = "http://www.meadowwoodmanor.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func mapButtonClicked(sender: AnyObject) {
        let regionDistance:CLLocationDistance = 10000
        var coordinates = CLLocationCoordinate2DMake(meadowWoodManorLat, meadowWoodManorLong)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        var options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        var placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        var mapItem = MKMapItem(placemark: placemark)
        mapItem.name = meadowWoodManorName
        mapItem.openInMapsWithLaunchOptions(options)
    }
    
    @IBAction func websiteButtonClicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: meadowWoodManorURL)!)
    }
    
    @IBAction func calendarButtonClicked(sender: AnyObject) {
        let store = EKEventStore()
        store.requestAccessToEntityType(EKEntityTypeEvent, completion: { (granted, error) -> Void in
            if granted {
                let event = EKEvent(eventStore: store)
                event.title = "Tina and Eric's Wedding!"
                event.notes = "Celebrate the big day with the lovely couple and have fun!"
                event.startDate = DateHelper.weddingDate()
                event.endDate = event.startDate.dateByAddingTimeInterval(6 * 60 * 60) // 6 hours
                event.calendar = store.defaultCalendarForNewEvents
                var err: NSError?
                store.saveEvent(event, span: EKSpanThisEvent, commit: true, error: &err)
                var alert = UIAlertController(title: "Successfully saved the even to your calendar!", message: "Looking forward to seeing you there", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
