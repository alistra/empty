//
//  ViewController.swift
//  Visit Again
//
//  Created by Piotr Mielcarzewicz on 31/10/16.
//  Copyright © 2016 Piotr Mielcarzewicz. All rights reserved.
//

import UIKit
import MapKit


var tracking = true


class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate
{
    
    @IBOutlet weak var map: MKMapView!
    
    var manager: CLLocationManager!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        map.showsUserLocation = true
        manager  = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        if activePlace == -1
        {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        else
        {
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
            let latDelta: CLLocationDegrees = 0.01
            let lonDelta: CLLocationDegrees = 0.01
            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
            
            self.map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = places[activePlace]["name"]
            self.map.addAnnotation(annotation)

        }
        
        
        
        let uilongpress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.action(_ :)))
        uilongpress.minimumPressDuration = 0.4
        
        map.addGestureRecognizer(uilongpress)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func action(_ gestureRecognizer: UIGestureRecognizer)
    {
        if gestureRecognizer.state == UIGestureRecognizerState.began
        {
            
            let touchPoint = gestureRecognizer.location(in: self.map)
            
            let newCoordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
            reverseGeoLocation(coordinate: newCoordinate)
             
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
        
        if tracking
        {
            self.map.setRegion(region, animated: true)
            tracking = false
        }
    }
    
    
    func reverseGeoLocation(coordinate: CLLocationCoordinate2D)
    {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            
            var title = ""
            
            if error == nil
            {
                if let p = placemarks?[0]
                {
                    var subThoroughfare: String = ""
                    var Thoroughfare: String = ""
                    
                    if p.subThoroughfare != nil
                    {
                        subThoroughfare = p.subThoroughfare!
                    }
                    
                    if p.thoroughfare != nil
                    {
                        Thoroughfare = p.thoroughfare!
                    }
                    
                    title = "\(Thoroughfare) \(subThoroughfare)"
                    
                }
            }
            
            if title == ""
            {
                title = "New Place!"
            }
           
            
            let alert = UIAlertController(title: "Type description:", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addTextField(configurationHandler: { (textField) in

            })
            
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
                if alert.textFields![0].text != nil
                {
                    let dsc = alert.textFields![0].text!
                    places.append(["description": dsc, "name": title, "lat": "\(coordinate.latitude)", "lon": "\(coordinate.longitude)"])
                    
                }
                else
                {
                    places.append(["description": title, "name": title, "lat": "\(coordinate.latitude)", "lon": "\(coordinate.longitude)"])
                }
                UserDefaults.standard.set(places, forKey: "places")
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = title
            
            self.map.addAnnotation(annotation)
        })
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

