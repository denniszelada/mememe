//
//  MememeViewController.swift
//  
//
//  Created by Dennis on 7/16/15.
//
//

import UIKit

class MememeViewController: UIViewController, UIImagePickerControllerDelegate {

    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
