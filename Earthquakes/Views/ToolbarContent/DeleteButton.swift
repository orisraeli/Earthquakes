//
//  DeleteButton.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

struct DeleteButton: View {
	var action: () -> Void = {}
	
    var body: some View {
		Button(action: action) {
			Label("Delete", systemImage: "trash")
		}
    }
}

#Preview {
    DeleteButton()
		.previewLayout(.sizeThatFits)
}
