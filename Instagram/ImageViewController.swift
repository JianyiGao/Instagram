//
//  ImageViewController.swift
//  Instagram
//
//  Created by Jianyi Gao 高健一 on 3/5/17.
//  Copyright © 2017 Jianyi Gao. All rights reserved.
//

import UIKit
import Parse

class ImageViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    var post:[Post]!
    var caption : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertMessage(titleString: String, messageString: String){
        let alertController = UIAlertController(title: titleString, message: messageString , preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
        
    }

    
    @IBAction func onLibrary(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func onCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func onAddCaption(_ sender: Any) {
        if(captionField.text != nil){
            caption = captionField.text!
        } else {
            self.alertMessage(titleString: "Oops", messageString: "No caption!")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.contentMode = .scaleAspectFit
        imagePicked.image = chosenImage
        dismiss(animated:true, completion: nil)
        
    }

    @IBAction func onSave(_ sender: Any) {
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        self.alertMessage(titleString: "Great", messageString: "Your photo has been saved to library!")
    }

    @IBAction func onPost(_ sender: Any) {
        Post.postUserImage(image: imagePicked.image, withCaption: caption) { (success: Bool, error: Error?) in
            if (success){
                self.alertMessage(titleString: "Awesome", messageString: "Your photo is posted!")
            } else {
                self.alertMessage(titleString: "Oops", messageString: (error?.localizedDescription)!)
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



