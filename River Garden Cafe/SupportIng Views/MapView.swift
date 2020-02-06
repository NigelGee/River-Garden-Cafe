//
//  MapView.swift
//  River Garden Cafe
//
//  Created by Nigel Gee on 27/01/2020.
//  Copyright © 2020 Nigel Gee. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    var deltaSpan: Double
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: 51.4874, longitude: 0.0015)
        let span = MKCoordinateSpan(latitudeDelta: deltaSpan, longitudeDelta: deltaSpan)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(deltaSpan: 0.002)
    }
}
