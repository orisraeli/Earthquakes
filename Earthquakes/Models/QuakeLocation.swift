//
//  QuakeLocation.swift
//  Earthquakes
//
//  Created by Or Israeli on 20/04/2024.
//

import Foundation

struct QuakeLocation: Decodable {
	var latitude: Double { properties.products.origin.first!.properties.latitude }
	var longitude: Double { properties.products.origin.first!.properties.longitude }
	private var properties: RootProperties
	
	struct RootProperties: Decodable {
		var products: Products
	}
	
	struct Products: Decodable {
		var origin: [Origin]
	}
	
	struct Origin: Decodable {
		var properties: OriginProperties
	}
	
	struct OriginProperties {
		var latitude: Double
		var longitude: Double
	}
}

extension QuakeLocation.OriginProperties: Decodable {
	private enum OriginPropertiesCodingKeys: String, CodingKey {
		case latitude
		case longitude
	}
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: OriginPropertiesCodingKeys.self)
		let rawLongitude = try container.decode(String.self, forKey: .longitude)
		let rawLatitude = try container.decode(String.self, forKey: .latitude)
		
		guard let longitude = Double(rawLongitude), let latitude = Double(rawLatitude) else {
			throw QuakeError.missingData
		}
		
		self.longitude = longitude
		self.latitude = latitude
	}
}