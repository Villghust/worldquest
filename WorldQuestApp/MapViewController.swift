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
        let pin = MKAnnotationView()
        pin.image = UIImage.init(named: "apple")
        pin.frame.size = CGSize(width: 30, height: 30)
        return pin
    }
    
    func addAnnotations() {
        let iguatemi = MKPointAnnotation()
        iguatemi.coordinate.latitude = -30.02376410917726
        iguatemi.coordinate.longitude = -51.161892400000056
        iguatemi.title = "iguatemi"
        mapView.addAnnotation(iguatemi)
        let ipiranga = MKPointAnnotation()
        ipiranga.coordinate.latitude = -30.05507550918886
        ipiranga.coordinate.longitude = -51.18687680000005
        ipiranga.title = "ipiranga"
        mapView.addAnnotation(ipiranga)
        let wallig = MKPointAnnotation()
        wallig.coordinate.latitude = -30.011935009172884
        wallig.coordinate.longitude = -51.160768899999994
        wallig.title = "wallig"
        mapView.addAnnotation(wallig)
    }
}



