//
//  QuakeDetail.swift
//  Earthquakes
//
//  Created by Or Israeli on 23/04/2024.
//

import SwiftUI

struct QuakeDetail: View {
	@EnvironmentObject private var provider: QuakesProvider
	@State private var location: QuakeLocation? = nil
	var quake: Quake

    var body: some View {
		VStack {
			QuakeMagnitude(quake: quake)
			Text(quake.place)
				.font(.title3)
				.bold()
			Text("\(quake.time.formatted())")
				.foregroundStyle(.secondary)
			
			if let location = self.location {
				Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))")
				Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))")
			}
		}
		.task {
			if self.location == nil {
				if let quakeLocation = quake.location {
					self.location = quakeLocation
				} else {
					self.location = try? await provider.location(for: quake)
				}
			}
		}
    }
}

#Preview {
	QuakeDetail(quake: Quake.preview)
}
