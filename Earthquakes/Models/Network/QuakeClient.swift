//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by Or Israeli on 21/04/2024.
//

import Foundation

actor QuakeClient {
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
	
	func quakeLocation(from url: URL) async throws -> QuakeLocation {
		if let cached = quakeCache[url] {
			switch cached {
				case .inProgress(let task):
					return try await task.value
				case .ready(let location):
					return location
			}
		}
		
		let task = Task<QuakeLocation, Error> {
			let data = try await downloader.httpData(from: url)
			let location = try decoder.decode(QuakeLocation.self, from: data)
			return location
		}
		
		quakeCache[url] = .inProgress(task)
		
		do {
			let location = try await task.value
			quakeCache[url] = .ready(location)
			return location
		} catch {
			quakeCache[url] = nil
			throw error
		}
		
	}
}
