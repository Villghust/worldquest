import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        addAnnotations()
    }
    
    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        mapView.removeOverlays(mapView.overlays)
        let circle = MKCircle(center: coordinate, radius: radius)
        mapView.add(circle)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if let location = locationManager.location {
                var region = MKCoordinateRegion()
                region.center.latitude = location.coordinate.latitude
                region.center.longitude = location.coordinate.longitude
                region.span.longitudeDelta = 0.05
                self.mapView.setRegion(region, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Authorization Denied", message: "If you do not authorize the usage of your location the app will not work.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close game", style: .cancel, handler: {action in exit(0)}))
            alert.addAction(UIAlertAction(title: "Manage Permissions", style: .default, handler: {
                action in
                UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        showCircle(coordinate: mapView.userLocation.coordinate, radius: 1000)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.fillColor = UIColor.green
            circleRenderer.strokeColor = UIColor.red
            circleRenderer.lineWidth = 2
            circleRenderer.alpha = 0.3
            return circleRenderer
        }
        return MKCircleRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pin = MKAnnotationView()
        if annotation.title == "shopping" {
            pin.image = UIImage.init(named: "_TAB_QUEST")
            pin.frame.size = CGSize(width: 30, height: 30)
        } else if annotation.title == "squares" {
            pin.image = UIImage.init(named: "sword")
            pin.frame.size = CGSize(width: 30, height: 30)
        } else {
            pin.image = UIImage.init(named: "hp")
            pin.frame.size = CGSize(width: 30, height: 30)
        }
        return pin
    }
    
    func addAnnotations() {
        // Shoppings -> Events
        let iguatemi = MKPointAnnotation()
        iguatemi.coordinate.latitude = -30.02376410917726
        iguatemi.coordinate.longitude = -51.161892400000056
        iguatemi.title = "shopping"
        iguatemi.subtitle = "iguatemi"
        mapView.addAnnotation(iguatemi)
        
        let ipiranga = MKPointAnnotation()
        ipiranga.coordinate.latitude = -30.05507550918886
        ipiranga.coordinate.longitude = -51.18687680000005
        ipiranga.title = "shopping"
        ipiranga.subtitle = "ipiranga"
        mapView.addAnnotation(ipiranga)
        
        let wallig = MKPointAnnotation()
        wallig.coordinate.latitude = -30.011935009172884
        wallig.coordinate.longitude = -51.160768899999994
        wallig.title = "shopping"
        wallig.subtitle = "wallig"
        mapView.addAnnotation(wallig)
        
        // Pubs -> Taverns
        let barbarosPub = MKPointAnnotation()
        barbarosPub.coordinate.latitude = -30.034759509181324
        barbarosPub.coordinate.longitude = -51.20823429999996
        barbarosPub.title = "pubs"
        barbarosPub.subtitle = "barbarosPub"
        mapView.addAnnotation(barbarosPub)
        
        let spoilerPub = MKPointAnnotation()
        spoilerPub.coordinate.latitude = -30.041415209183807
        spoilerPub.coordinate.longitude = -51.21807910000001
        spoilerPub.title = "pubs"
        spoilerPub.subtitle = "spoilerPub"
        mapView.addAnnotation(spoilerPub)
        
        let dublinPub = MKPointAnnotation()
        dublinPub.coordinate.latitude = -30.02409220917742
        dublinPub.coordinate.longitude = -51.2026444
        dublinPub.title = "pubs"
        dublinPub.subtitle = "dublinPub"
        mapView.addAnnotation(dublinPub)
        
        // Squares -> Squares (OHH YEAH!!)
        let germaniaSquare = MKPointAnnotation()
        germaniaSquare.coordinate.latitude = -30.022529409176798
        germaniaSquare.coordinate.longitude = -51.158572549999974
        germaniaSquare.title = "squares"
        germaniaSquare.subtitle = "germaniaSquare"
        mapView.addAnnotation(germaniaSquare)
        
        let redencaoSquare = MKPointAnnotation()
        redencaoSquare.coordinate.latitude = -30.03873580918278
        redencaoSquare.coordinate.longitude = -51.21850610000001
        redencaoSquare.title = "squares"
        redencaoSquare.subtitle = "redencaoSquare"
        mapView.addAnnotation(redencaoSquare)
        
        let marinhaSquare = MKPointAnnotation()
        marinhaSquare.coordinate.latitude = -30.03949890918311
        marinhaSquare.coordinate.longitude = -51.22856200000001
        marinhaSquare.title = "squares"
        marinhaSquare.subtitle = "marinhaSquare"
        mapView.addAnnotation(marinhaSquare)
    }
}



