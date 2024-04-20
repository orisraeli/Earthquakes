//
//  Quake.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import Foundation

struct Quake {
	let magnitude: Double
	let place: String
	let time: Date
	let code: String
	let detail: URL
}

//MARK: - Identifiable conformance

extension Quake: Identifiable {
	var id: String { code }
}

//MARK: - Sample Data

extension Quake {
	static let sampleQuake = Quake(magnitude: 1.0,
								   place: "Shakey Acres",
								   time: Date(timeIntervalSinceNow: -1000),
								   code: "nc73649170",
								   detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!)
	
	static let sampleQuakes: [Quake] = [
		Quake(magnitude: 0.8,
			  place: "Shakey Acres",
			  time: Date(timeIntervalSinceNow: -1000),
			  code: "nc73649170",
			  detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!),
		Quake(magnitude: 2.2,
			  place: "Rumble Alley",
			  time: Date(timeIntervalSinceNow: -5000),
			  code: "hv72783692",
			  detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/hv72783692")!)
	]
}
