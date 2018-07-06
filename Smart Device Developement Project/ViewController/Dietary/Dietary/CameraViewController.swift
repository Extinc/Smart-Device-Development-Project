//
//  CameraViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 29/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var selectPicture: UIButton!
    @IBOutlet weak var takePicture: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // we check if this device has a camera
        /*
        if !(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            // If not, we will just hide the takePicture button
            //
            takePicture.isHidden = true
        }
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        // Setting this to true allows the user to crop and scale
        // the image to a square after the photo is taken.
        //
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(picker, animated: true)
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        // Setting this to true allows the user to crop and scale
        // the image to a square after the image is selected
        //
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true)
        
    }
    
    // This function is called after the user took the picture,
    // or selected a picture from the photo library.
    // When that happens, we simply assign the image binary,
    // represented by UIImage, into the imageView we created.
    //
    // iOS doesn't close the picker controller
    // automatically, so we have to do this ourselves by calling
    //dismissViewControllerAnimated
    //
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) throws {
        let chosenImage : UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imageView!.image = chosenImage
        
        /*
        let model = try VNCoreMLModel(for: food().model)
        let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    print(error as Any)
                    return
            }
            
            DispatchQueue.main.async {
                self?.test.text = topResult.identifier + " (confidence \(topResult.confidence * 100)%)"
            }
        })
 
        
        let handler = VNImageRequestHandler(cgImage: chosenImage.cgImage!, options: [:])
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
        */
        // This saves the image selected / shot by the user
        //
        UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil)
        // This closes the picker
        //
        picker.dismiss(animated: true)
    }
    
    // This function is called after the user decides not to
    // take/select any picture. iOS doesn't close the picker controller
    // automatically, so we have to do this ourselves by calling
    // dismissViewControllerAnimated
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func detect(image: UIImage) throws {
        /*
        let model = try VNCoreMLModel(for: food().model)
        let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    print(error as Any)
                    return
            }
            
            DispatchQueue.main.async {
                self?.test.text = topResult.identifier + " (confidence \(topResult.confidence * 100)%)"
            }
        })
 
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
         */
    }

}
