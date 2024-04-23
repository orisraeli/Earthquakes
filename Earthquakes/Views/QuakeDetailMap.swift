//
//  QuakeDetailMap.swift
//  Earthquakes
//
//  Created by Or Israeli on 23/04/2024.
//

import MapKit
import SwiftUI

struct QuakeDetailMap: View {
	@State private var position = MapCameraPosition.region(MKCoordinateRegion())
	
	let location: QuakeLocation
	let tintColor: Color
	private var place: QuakePlace
	
	init(location: QuakeLocation, tintColor: Color) {
		self.location = location
		self.tintColor = tintColor
		self.place = QuakePlace(location: location)
	}
	
	var body: some View {
		Map(position: $position) {
			Marker("", coordinate: place.location)
				.tint(tintColor)
		}
		.onAppear {
			withAnimation {
				let center = place.location
				let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
				let region = MKCoordinateRegion(center: center, span: span)
				
				position = MapCameraPosition.region(region)
			}
		}
	}
}

struct QuakePlace: Identifiable {
	let id: UUID
	let location: CLLocationCoordinate2D
	
	init(id: UUID = UUID(), location: QuakeLocation) {
		self.id = id
		self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
	}
}
