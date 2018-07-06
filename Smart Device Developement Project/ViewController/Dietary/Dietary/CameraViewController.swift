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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        picker.dismiss(animated: true, completion: nil)
        self.imageView.image = image
        try? self.detect(image: image)
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
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
        
    }
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func detect(image: UIImage) throws {
        
        let model = try VNCoreMLModel(for: food().model)
        let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    print(error as Any)
                    return
            }
            
            DispatchQueue.main.async {
                self?.test.text = topResult.identifier + " (confidence \(topResult.confidence * 100)%)"
                print(self?.test.text as Any)
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
    }
}
