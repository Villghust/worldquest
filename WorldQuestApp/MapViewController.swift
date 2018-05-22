import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -30.05507550918886, longitude: -51.18687680000005), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(region, animated: true)
        
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
        } else if status == .denied{
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
        
        var pin = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if pin == nil{
            pin = QuestAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            pin?.canShowCallout = false
        }else{
            pin?.annotation = annotation
        }
        
        
        if annotation.title == "shopping" {
            pin?.image = UIImage.init(named: "_TAB_QUEST")
            pin?.frame.size = CGSize(width: 30, height: 30)
        } else if annotation.title == "squares" {
            pin?.image = UIImage.init(named: "sword")
            pin?.frame.size = CGSize(width: 30, height: 30)
        } else {
            pin?.image = UIImage.init(named: "hp")
            pin?.frame.size = CGSize(width: 30, height: 30)
        }
        return pin
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation{
            return
        }
        
        let questAnnotation: QuestAnnotation = QuestAnnotation.init(coordinate: (view.annotation?.coordinate)!)
        
        
        guard let views = Bundle.main.loadNibNamed("QuestCallout", owner: nil, options: nil) as? [UIView] else { return }
        
        let calloutView = views[0] as! QuestCalloutView
        
        let point = CLLocation(latitude: (questAnnotation.coordinate.latitude), longitude: (questAnnotation.coordinate.longitude))
        
        if let distance = locationManager.location?.distance(from: point){
            if distance.binade>1000.0{
                calloutView.btn.isHidden = true
            }
        }
        
        calloutView.layer.cornerRadius = 12
        calloutView.clipsToBounds = true
        
        if(view.annotation?.subtitle == "quest"){
            calloutView.imgBack.image = UIImage(named: "QuestCallout")
            calloutView.descLabel.text = "Mate 5 Goblins em 2 dias"
            calloutView.rewarddescLabel.text = "5 XP"
        }
        
        if(view.annotation?.subtitle == "battle"){
            calloutView.questLabel.text = "Battle"
            calloutView.imgBack.image = UIImage(named: "QuestCallout")
            calloutView.descLabel.text = "Inimigos: 1 goblin"
            calloutView.rewarddescLabel.text = "2 XP e 1 gold"
        }
        
        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: QuestAnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    
    
    func addAnnotations() {
        // Shoppings -> Events
        let iguatemi = MKPointAnnotation()
        iguatemi.coordinate.latitude = -30.02376410917726
        iguatemi.coordinate.longitude = -51.161892400000056
        iguatemi.title = "shopping"
        iguatemi.subtitle = "quest"
        mapView.addAnnotation(iguatemi)
        
        let ipiranga = MKPointAnnotation()
        ipiranga.coordinate.latitude = -30.05507550918886
        ipiranga.coordinate.longitude = -51.18687680000005
        ipiranga.title = "shopping"
        ipiranga.subtitle = "quest"
        mapView.addAnnotation(ipiranga)
        
        let wallig = MKPointAnnotation()
        wallig.coordinate.latitude = -30.011935009172884
        wallig.coordinate.longitude = -51.160768899999994
        wallig.title = "shopping"
        wallig.subtitle = "quest"
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
        germaniaSquare.subtitle = "battle"
        mapView.addAnnotation(germaniaSquare)
        
        let redencaoSquare = MKPointAnnotation()
        redencaoSquare.coordinate.latitude = -30.03873580918278
        redencaoSquare.coordinate.longitude = -51.21850610000001
        redencaoSquare.title = "squares"
        redencaoSquare.subtitle = "battle"
        mapView.addAnnotation(redencaoSquare)
        
        let marinhaSquare = MKPointAnnotation()
        marinhaSquare.coordinate.latitude = -30.03949890918311
        marinhaSquare.coordinate.longitude = -51.22856200000001
        marinhaSquare.title = "squares"
        marinhaSquare.subtitle = "battle"
        mapView.addAnnotation(marinhaSquare)
    }
    
    
    
}



