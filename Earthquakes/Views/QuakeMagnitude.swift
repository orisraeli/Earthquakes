//
//  QuakeMagnitude.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

struct QuakeMagnitude: View {
	let quake: Quake
	
	var body: some View {
		RoundedRectangle(cornerRadius: 8)
			.fill(.black)
			.frame(width: 80, height: 60)
			.overlay {
				Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
					.font(.title)
					.bold()
					.foregroundStyle(quake.color)
			}
	}
}

#Preview {
	QuakeMagnitude(quake: Quake.sampleQuake)
}
