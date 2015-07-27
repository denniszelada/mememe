//
//  MemeCollectionViewController.swift
//  mememe
//
//  Created by Dennis on 7/26/15.
//  Copyright (c) 2015 Dennis. All rights reserved.
//

import Foundation

import UIKit


class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        self.memes = applicationDelegate.memes
        
        
    }
    

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeMeCollectionViewCell", forIndexPath: indexPath) as! MemeMeCollectionViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the image
        cell.memeImageView?.image = meme.memedImage
        cell.memeImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
            return 3
    }
    

    @IBAction func addMeme(sender: AnyObject) {
        let memeMeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeViewController")! as! MememeViewController
        
        self.presentViewController(memeMeViewController, animated: true, completion: nil)

    }
    
}
