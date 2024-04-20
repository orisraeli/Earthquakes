//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by Or Israeli on 20/04/2024.
//

import XCTest
@testable import Earthquakes

final class EarthquakesTests: XCTestCase {

	func testGeoJSONDecoderDecodesQuake() throws {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .millisecondsSince1970
		let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
		
		XCTAssertEqual(quake.code, "73649170")
		
		
		// test time value
		let expectedSeconds = TimeInterval(1636129710550) / 1000
		let decodedSeconds = quake.time.timeIntervalSince1970
		
		XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
		
		// test tsunami value
		XCTAssertEqual(quake.tsunami, 0)
	}

}
