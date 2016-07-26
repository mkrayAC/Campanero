//
//  MapViewController.swift
//  Campanero
//
//  Created by Oscar Hiram Alvarez Campos on 18/07/16.
//  Copyright © 2016 Nebusens. All rights reserved.
//

import UIKit
import GoogleMaps

//funcion para enviar datos de un controller a otro

protocol SaveDirectionDelegate: class{

    func sendDirection(direction:String)


}

//Aqui van los outlets y todas la variables

class MapViewController: UIViewController {
    
    var delegate: SaveDirectionDelegate?
    
    
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.myLocationEnabled = true
        

        //añadir boton con codigo a la barra
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .Plain, target: self, action: #selector(addTapped))
            }
    
    //regresar a ventana option despues de guardar 
    func addTapped()  {
        
        self.navigationController?.popViewControllerAnimated(true)
        delegate?.sendDirection(directionLabel.text!)
        
    }
    


    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {//regresa las cordenadas del punto seleccionado y poner marcador
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                // 3
                let lines = address.lines
                self.directionLabel.text = lines!.joinWithSeparator("\n")
                print(lines!.joinWithSeparator("\n"))
                self.mapView.clear()
                let marker = GMSMarker()
                marker.position = coordinate
                marker.title = lines!.joinWithSeparator("\n")
                
                dispatch_async(dispatch_get_main_queue(),{
                    
                    marker.map = self.mapView
                })
                // 4
                UIView.animateWithDuration(0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: CLLocationManagerDelegate, GMSMapViewDelegate{ //extension para utilizar los mapas y obtener la localizacion
    
    // 2
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
            
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
        }
        
    }
     // va en conjunto con la funcion geocoder
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        
        
       
        
          reverseGeocodeCoordinate(coordinate)
        
    }
 

    

}

































