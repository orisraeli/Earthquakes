//
//  CacheEntryObject.swift
//  Earthquakes
//
//  Created by Or Israeli on 23/04/2024.
//

import Foundation

final class CacheEntryObject {
	let entry: CacheEntry
	
	init(entry: CacheEntry) {
		self.entry = entry
	}
}

enum CacheEntry {
	case inProgress(Task<QuakeLocation, Error>)
	case ready(QuakeLocation)
}
