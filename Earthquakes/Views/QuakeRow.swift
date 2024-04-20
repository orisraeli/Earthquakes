//
//  QuakeRow.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

struct QuakeRow: View {
	let quake: Quake
	
    var body: some View {
		HStack {
			QuakeMagnitude(quake: quake)
			VStack(alignment: .leading) {
				Text(quake.place)
					.font(.title3)
				Text("\(quake.time.formatted(.relative(presentation: .named)))")
					.foregroundStyle(.secondary)
			}
		}
		.padding(.vertical, 8)
    }
}

#Preview {
	QuakeRow(quake: Quake.sampleQuake)
}
