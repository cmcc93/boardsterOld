//
//  GearTableViewController.swift
//  Terranaut
//
//  Created by Jane Appleseed on 5/27/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit

class GearTableViewController: UITableViewController {
    // MARK: Properties
    
    var gears = [Gear]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved gears, otherwise load sample data.
        if let savedGears = loadGears() {
            gears += savedGears
        } else {
            // Load the sample data.
            loadSampleGears()
        }
    }
    
    func loadSampleGears() {
        let photo1 = UIImage(named: "gear1")!
        let gear1 = Gear(name: "Rusty Rooster", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "gear2")!
        let gear2 = Gear(name: "Strive The Solution", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "gear3")!
        let gear3 = Gear(name: "Al Merrick The Peregrine", photo: photo3, rating: 3)!
        
        gears += [gear1, gear2, gear3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gears.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GearTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GearTableViewCell
        
        // Fetches the appropriate gear for the data source layout.
        let gear = gears[indexPath.row]
        
        cell.nameLabel.text = gear.name
        cell.photoImageView.image = gear.photo
        cell.ratingControl.rating = gear.rating
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            gears.removeAtIndex(indexPath.row)
            saveGears()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let gearDetailViewController = segue.destinationViewController as! GearViewController
            
            // Get the cell that generated this segue.
            if let selectedGearCell = sender as? GearTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedGearCell)!
                let selectedGear = gears[indexPath.row]
                gearDetailViewController.gear = selectedGear
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new gear.")
        }
    }
    

    @IBAction func unwindToGearList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? GearViewController, gear = sourceViewController.gear {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing gear.
                gears[selectedIndexPath.row] = gear
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new gear.
                let newIndexPath = NSIndexPath(forRow: gears.count, inSection: 0)
                gears.append(gear)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the gears.
            saveGears()
        }
    }
    
    // MARK: NSCoding
    
    func saveGears() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(gears, toFile: Gear.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save gears...")
        }
    }
    
    func loadGears() -> [Gear]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Gear.ArchiveURL.path!) as? [Gear]
    }
}
