//
//  NSCahse+Subscript.swift
//  Earthquakes
//
//  Created by Or Israeli on 23/04/2024.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
	subscript(_ url: URL) -> CacheEntry? {
		get {
			let key = url.absoluteString as NSString
			let value = object(forKey: key)
			return value?.entry
		}
		
		set {
			let key = url.absoluteString as NSString
			if let entry = newValue {
				let value = CacheEntryObject(entry: entry)
				setObject(value, forKey: key)
			} else {
				removeObject(forKey: key)
			}
		}
	}
}
