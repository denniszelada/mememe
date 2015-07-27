//
//  MemeDetailViewController.swift
//  mememe
//
//  Created by Dennis on 7/26/15.
//  Copyright (c) 2015 Dennis. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var meme: Meme!
    
  
    @IBOutlet weak var memeDetailImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        memeDetailImage.image = meme.memedImage
        memeDetailImage.contentMode = UIViewContentMode.ScaleAspectFit
    }
    

}
