//
//  Created by MJMC 8/06/2021.
//  Copyright © 2021 MJMC. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , CLLocationManagerDelegate , MKMapViewDelegate {

    @IBOutlet weak var MyMap: MKMapView!
    @IBOutlet weak var btnIcon: UIButton!
    
    var activeLocationBool = false
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Realice cualquier configuración adicional después de cargar la vista.
        activeLocationBool = false
        btnIcon.setBackgroundImage(UIImage (named: "Image"), for: UIControl.State.normal)
        
        self.locationManager.requestAlwaysAuthorization()
        
        // Para usar en primer plano
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        MyMap.delegate = self
        MyMap.mapType = .standard
        MyMap.isZoomEnabled = true
        MyMap.isScrollEnabled = true
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        let region = MKCoordinateRegion(center: locValue, latitudinalMeters: 0.05, longitudinalMeters: 0.05)
        
        //remove previous anotation
        
        let annotationsToRemove = MyMap.annotations.filter
        {
            $0 !== MyMap.userLocation
        }
        MyMap.removeAnnotations( annotationsToRemove )
        
        MyMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation ()
        annotation.coordinate = locValue
        annotation.title = "mw_498"
        annotation.subtitle = "CurrentLocation"
        MyMap.addAnnotation(annotation)
        
        
        
    }

    @IBAction func btnPress(_ sender: Any) {
        
        if !activeLocationBool {
             locationManager.startUpdatingLocation()
            btnIcon.setBackgroundImage(UIImage (named: "iconoCambio"), for: UIControl.State.normal)
            
            activeLocationBool = true
        }
        else {
            locationManager.stopUpdatingLocation()
            btnIcon.setBackgroundImage(UIImage (named: "Image"), for: UIControl.State.normal)
            
            activeLocationBool = false
        }
        
    }
    
}

