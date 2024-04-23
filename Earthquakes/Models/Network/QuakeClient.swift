//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by Or Israeli on 21/04/2024.
//

import Foundation

class QuakeClient {
	var quakes: [Quake] {
		get async throws {
			let data = try await downloader.httpData(from: feedURL)
			let decoded = try decoder.decode(GeoJSON.self, from: data)
			return decoded.quakes
		}
	}
	
	private lazy var decoder: JSONDecoder = {
		let coder = JSONDecoder()
		coder.dateDecodingStrategy = .millisecondsSince1970
		return coder
	}()
	
	private let quakeCache: NSCache<NSString, CacheEntryObject> = NSCache()
	
	private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
	
	private let downloader: any HTTPDataDownloader
	
	init(downloader: any HTTPDataDownloader = URLSession.shared) {
		self.downloader = downloader
	}
}
