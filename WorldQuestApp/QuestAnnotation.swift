//
//  QuestAnnotation.swift
//  WorldQuestApp
//
//  Created by Fernando Locatelli Maioli on 18/05/18.
//  Copyright © 2018 World Quest. All rights reserved.
//

import MapKit

class QuestAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var desc: String!
    var image: UIImage!
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
        
    }
}
