//
//  QuakeError.swift
//  Earthquakes
//
//  Created by Or Israeli on 20/04/2024.
//

import Foundation

enum QuakeError: Error {
	case missingData
}

extension QuakeError: LocalizedError {
	var errorDescription: String? {
		switch self {
			case .missingData:
				return NSLocalizedString(
					"Found and will discard a quake missing a valid code, magnitude, place, detail or time.",
					comment: ""
				)
		}
	}
}
