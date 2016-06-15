//
//  ImagePickerController.swift
//  Sidekicks
//
//  Created by mac rent on 13/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import UIKit

class ImagePickerController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var filterSlider: UISlider!
    @IBOutlet weak var flickrBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var filterLabel: UILabel!
    
    var filterCounter: Int = 0;
    var stack: Bool = false;
    var model = Model.sharedInstance
    
    @IBAction func swapStacking(sender: AnyObject) {
        stack = !stack
    }
   
    @IBAction func previousFilter(sender: AnyObject) {
        changeFilter(-1)
    }
    
    @IBAction func nextFilter(sender: AnyObject) {
        changeFilter(1)
    }
    
    @IBAction func cameraBtn(sender: AnyObject) {
        loadCamera()
    }
    
    @IBAction func selectImageBtn(sender: AnyObject) {
        loadImagePicker()
    }
    
    @IBOutlet weak var selectedImage: UIImageView!
    let imagePicker = UIImagePickerController()
    
    
    @IBAction func saveButton(sender: AnyObject) {
        model.addImage(newImage!);
    }
    
    @IBAction func intensitySlider(sender: UISlider) {
        if stack {
            filterManager.setupFilter(newImage!)
        }
        
        if filterCounter == 0 {
            print ("No filter chosen")
        }
        else if filterCounter == 1 {
            newImage = filterManager.sepiaSliderFilter(newImage!, value: sender.value)
            selectedImage.image = newImage
        }
        else if filterCounter == 2 {
            newImage = filterManager.vignetteSliderFilter(newImage!, value: sender.value)
            selectedImage.image = newImage
        }
        
        else if filterCounter == 3 {
            newImage = filterManager.bloomSliderFilter(newImage!, value: sender.value)
            selectedImage.image = newImage
        }
        
        else if filterCounter == 4 {
            newImage = filterManager.blurSliderFilter(newImage!, value: sender.value)
            selectedImage.image = newImage
        }
    }
    
    let filterManager = FilterManager()
    
    var newImage: UIImage?
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        filterSlider.enabled = false
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        flickrBtn.imageView!.contentMode = .ScaleAspectFit
        selectBtn.imageView!.contentMode = .ScaleAspectFit
        cameraBtn.imageView!.contentMode = .ScaleAspectFit
        if (newImage != nil){
            filterManager.setupFilter(newImage!)
            //filterManager.beginImage = newImage!
            selectedImage.image = newImage
            selectedImage.contentMode = .ScaleAspectFit
        }
    }
    
    func loadImagePicker(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func loadCamera(){
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        imagePicker.cameraCaptureMode = .Photo
        imagePicker.modalPresentationStyle = .FullScreen
        presentViewController(imagePicker, animated: true, completion: nil)
        }
        else {noCamera()}
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style: .Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage.contentMode = .ScaleAspectFit
            newImage = pickedImage
            selectedImage.image = newImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func flickrSelection(resultNum: Int){
        //selectedImage.contentMode = .ScaleAspectFit
        //selectedImage.image = pickedImage
        let flickrImage = FlickrSearch.sharedInstance.searchImages[resultNum] as UIImage!
        newImage = flickrImage
    }
    
    func changeFilter(moveNum: Int){
        filterCounter += moveNum
        if (filterCounter < 0)
        {
            filterCounter = 0
        }
        if (filterCounter == 0){
            filterLabel.text! = "Filter"
            filterSlider.enabled = false
        }
        else if filterCounter == 1{
            filterLabel.text! = "Sepia"
            filterSlider.value = 0.5
            filterSlider.enabled = true
        }
        
        else if filterCounter == 2{
            filterLabel.text! = "Vignette"
            filterSlider.value = 0.5
            filterSlider.enabled = true
        }
        else if filterCounter == 3 {
            filterLabel.text! = "Bloom"
            filterSlider.value = 0.5
            filterSlider.enabled = true
        }
        else if filterCounter == 4{
            filterLabel.text! = "Blur"
            filterSlider.value = 0.5
            filterSlider.enabled = true
        }
        
        else if filterCounter > 4 {
            filterCounter = 4
        }
       
    }

    
}
