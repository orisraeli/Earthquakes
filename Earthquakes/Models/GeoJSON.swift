//
//  GeoJSON.swift
//  Earthquakes
//
//  Created by Or Israeli on 20/04/2024.
//

import Foundation

struct GeoJSON: Decodable {
	private enum RootCodingKeys: String, CodingKey {
		case features
	}
	
	private enum FeaturesCodingKeys: String, CodingKey {
		case properties
	}

	private(set) var quakes: [Quake] = []
	
	init(from decoder: any Decoder) throws {
		let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
		var featuresContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
		
		while !featuresContainer.isAtEnd {
			let propertiesContainer = try featuresContainer.nestedContainer(keyedBy: FeaturesCodingKeys.self)
			
			if let properties = try? propertiesContainer.decode(Quake.self, forKey: .properties) {
				quakes.append(properties)
			}
		}
	}
}
