import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, MyProtocol {
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var ref: DatabaseReference!
    var quests = [Quest]()
    var questsJaEscolhidas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        ref = Database.database().reference()
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -30.05507550918886, longitude: -51.18687680000005), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView.setRegion(region, animated: true)
        
        self.ref.child("usuarios").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: {snapshot in
            let value = snapshot.value as? NSDictionary
            guard let quests = value?["quests"] as? [String] else {return}
            self.questsJaEscolhidas = quests
        })
        
        addAnnotations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "_TAB_MAP"), tag: 2)
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
        calloutView.delegate = self
        
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
            calloutView.descLabel.text = "Mate 5 Goblins"
            calloutView.rewarddescLabel.text = "5 XP"
        }
        
        if(view.annotation?.subtitle == "battle"){
            calloutView.questLabel.text = "Battle"
            calloutView.imgBack.image = UIImage(named: "QuestCallout")
            calloutView.descLabel.text = "Inimigos: 1 goblin"
            calloutView.rewarddescLabel.text = "2 XP"
        }
        
        let quest = quests.first { (quest) -> Bool in
            CLLocationDegrees(truncating: quest.latitude) == questAnnotation.coordinate.latitude &&
                CLLocationDegrees(truncating: quest.longitude) == questAnnotation.coordinate.longitude
        }
        calloutView.quest = quest
        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
        
    }
    
    func sendData(quest: Quest) {
        if quest.subtitulo == "quest" {
            ref.child("usuarios").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: {snapshot in
                let value = snapshot.value as? NSDictionary
                guard var quests = value?["quests"] as? [AnyObject] else {
                    return self.ref.child("usuarios/\(Auth.auth().currentUser!.uid)/quests")
                        .setValue(["0": quest.id])
                }
                
                quests.append(quest.id as AnyObject)
                self.ref.child("usuarios/\(Auth.auth().currentUser!.uid)/quests")
                    .setValue(quests)
                
            })
            
            for annotation in mapView.annotations{
                if annotation.coordinate.latitude == CLLocationDegrees(truncating: quest.latitude) &&
                    annotation.coordinate.longitude == CLLocationDegrees(truncating: quest.longitude) {
                    mapView.removeAnnotation(annotation)
                }
            }
        } else {
            self.performSegue(withIdentifier: "MapToBattle", sender: nil)
        }
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
        
        ref.child("quests").observe(.childAdded, with: { (snapshot) -> Void in
            
            let quest = Quest()
            quest.id = snapshot.key
            
            if self.questsJaEscolhidas.contains(quest.id) {
                return
            }
            
            for child in snapshot.children.allObjects as? [DataSnapshot] ?? [] {
                switch child.key {
                    case "latitude":
                        quest.latitude = child.value as! NSNumber
                    case "longitude":
                        quest.longitude = child.value as! NSNumber
                    case "titulo":
                        quest.titulo = child.value as! String
                    case "subtitulo":
                        quest.subtitulo = child.value as! String
                    default:
                        return
                    
                }
            }
            
            self.quests.append(quest)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = CLLocationDegrees(truncating: quest.latitude)
            annotation.coordinate.longitude = CLLocationDegrees(truncating: quest.longitude)
            annotation.title = quest.titulo
            annotation.subtitle = quest.subtitulo
            self.mapView.addAnnotation(annotation)
        })
        
//        // Pubs -> Taverns
//        let barbarosPub = MKPointAnnotation()
//        barbarosPub.coordinate.latitude = -30.034759509181324
//        barbarosPub.coordinate.longitude = -51.20823429999996
//        barbarosPub.title = "pubs"
//        barbarosPub.subtitle = "barbarosPub"
//        mapView.addAnnotation(barbarosPub)
//
//        let spoilerPub = MKPointAnnotation()
//        spoilerPub.coordinate.latitude = -30.041415209183807
//        spoilerPub.coordinate.longitude = -51.21807910000001
//        spoilerPub.title = "pubs"
//        spoilerPub.subtitle = "spoilerPub"
//        mapView.addAnnotation(spoilerPub)
//
//        let dublinPub = MKPointAnnotation()
//        dublinPub.coordinate.latitude = -30.02409220917742
//        dublinPub.coordinate.longitude = -51.2026444
//        dublinPub.title = "pubs"
//        dublinPub.subtitle = "dublinPub"
//        mapView.addAnnotation(dublinPub)
    }
    
    
    
}



