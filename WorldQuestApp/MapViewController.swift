
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
    
    
    
    
    
    
    
    
    
    
    
    
}



