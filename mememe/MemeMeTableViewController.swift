//
//  MemeMeTableViewController.swift
//  mememe
//
//  Created by Dennis on 7/26/15.
//  Copyright (c) 2015 Dennis. All rights reserved.
//

import UIKit

class MemeMeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        self.memes = applicationDelegate.memes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! UITableViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText
        cell.imageView?.image = meme.memedImage
        
        
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = meme.bottomText
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("didselected")
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    


    @IBAction func addNewMeme(sender: AnyObject) {
        let memeMeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeViewController")! as! MememeViewController
        
        self.presentViewController(memeMeViewController, animated: true, completion: nil)
        
    }
}
