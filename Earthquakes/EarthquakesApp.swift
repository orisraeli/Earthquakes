//
//  EarthquakesApp.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

@main
struct EarthquakesApp: App {
	@StateObject var quakesProvider = QuakesProvider()
	
    var body: some Scene {
        WindowGroup {
            QuakesView()
				.environmentObject(quakesProvider)
        }
    }
}
