//
//  MememeViewController.swift
//  
//
//  Created by Dennis on 7/16/15.
//
//

import UIKit

class MememeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var toolbar: UIToolbar!
    
    
    @IBOutlet weak var imagePickerViewer: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerViewer.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
