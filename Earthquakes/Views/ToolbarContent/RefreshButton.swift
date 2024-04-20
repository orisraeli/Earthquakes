//
//  RefreshButton.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

struct RefreshButton: View {
	var action: () -> Void = {}
	
    var body: some View {
		Button(action: action) {
			Label("Refresh", systemImage: "arrow.clockwise")
		}
    }
}

#Preview {
    RefreshButton()
		.previewLayout(.sizeThatFits)
}
