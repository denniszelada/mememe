//
//  MememeViewController.swift
//  
//
//  Created by Dennis on 7/16/15.
//
//

import UIKit

class MememeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var imagePickerViewer: UIImageView!
    
    @IBOutlet weak var sharedButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    var user_has_entered_top: Bool!
    var user_has_entered_bottom: Bool!
    var current_edited_field: UITextField!
    var memes: [Meme]!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        topText.defaultTextAttributes = memeTextAttributes
        topText.text = "TOP"
        topText.textAlignment = NSTextAlignment.Center
        topText.delegate = self
        user_has_entered_top = false
        
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = NSTextAlignment.Center
        bottomText.delegate = self
        user_has_entered_bottom = false
        
        sharedButton.enabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        sharedButton.enabled = true
    }

    @IBAction func pickAPhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        sharedButton.enabled = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerViewer.image = image
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if current_edited_field == bottomText {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }

    }
    
    func keyboardWillHide(notification: NSNotification) {
        if current_edited_field == bottomText {
            view.frame.origin.y = 0
        }
    }

    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
   
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.text == "TOP" && !user_has_entered_top{
            textField.text = ""
            user_has_entered_top = true
        }
        if textField.isEqual(bottomText) && !user_has_entered_bottom{
            textField.text = ""
            user_has_entered_bottom = true
        }
        current_edited_field = textField
    }
    
    
    func saveMeme(){
        var meme = Meme(topText: topText.text, bottomText: bottomText.text, image: imagePickerViewer.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar
        toolbar.hidden = true
        navBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        toolbar.hidden = false
        toolbar.hidden = false
        
        return memedImage
        
    }

    @IBAction func shareMeme(sender: AnyObject) {
        
        saveMeme()
        
        let objectsToShare = [generateMemedImage()]
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = activityCompletionHandler
        presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func activityCompletionHandler(activityType: String!,
        completed: Bool,
        returneditems: [AnyObject]!,
        activityError: NSError!){
            if completed && activityError == nil{
                var tabBarController:UITabBarController
                tabBarController = storyboard!.instantiateViewControllerWithIdentifier("SavedMemesViewTabBarController") as! UITabBarController
                presentViewController(tabBarController, animated: true, completion: nil)
            } else
            {
                navBar.hidden = false
            }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }


}
