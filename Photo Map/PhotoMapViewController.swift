//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

/* -- Comment -- */

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate  {
    
    /* ---- TODO: Create mapView outlet*/
    @IBOutlet weak var mapView: MKMapView!
    
    // Store picked image
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        let mapCenter = CLLocationCoordinate2D(latitude: 39.6295 , longitude:-79.9559 )
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        // Set animated property to true to animate the transition to the region
        mapView.setRegion(region, animated: false)
        
        locationsPickedLocation(coords: mapCenter)
        
        
       
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        pickedImage = editedImage
        
        
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "tagSegue", sender: nil)
        }
        
        
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
//        vc.sourceType = UIImagePickerController.SourceType.camera
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    

        
        
    }
    
  
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView!.canShowCallout = true
            annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
        }
        
        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
        // Add the image you stored from the image picker
        imageView.image = pickedImage
        
        
        
        return annotationView
    }
    
    /* ------ TODO: Set initial location after launching app */
    
    
    /* ----- TODO: Instantiate UIImagePicker after camera button tapped */

    
    /* ----- TODO: Override prepare (for segue) funcion to show Present LocationsViewController */
    
    
    
    /* ----- TODO: Retrieve coordinates from LocationsViewController   */
    
    
    
    /* ----- TODO: add pin to the map */
    func locationsPickedLocation(coords:CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        let latitude = coords.latitude
        let longitude = coords.longitude
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = locationCoordinate
        
        annotation.title = "Founders Den"
        mapView.addAnnotation(annotation)
    }
    
    
    /* ----- TODO: Customize mapview to add custom map notations */
    
    
    
    
    // Instantiate Image Picker and set delegate to this view controller
    func selectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // Present camera, if available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            imagePicker.sourceType = .camera
            
            // Present photo library
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            imagePicker.sourceType = .photoLibrary
            // Present imagePicker source type (either camera or library)
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    

}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
