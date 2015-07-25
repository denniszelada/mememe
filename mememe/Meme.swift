//
//  Meme.swift
//  mememe
//
//  Created by Dennis on 7/25/15.
//  Copyright (c) 2015 Dennis. All rights reserved.
//

import Foundation
import UIKit

class Meme{
    var topText: String
    var bottomText: String
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}