//
//  Quakes.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

struct Quakes: View {
	@AppStorage("lastUpdated")
	var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
	@State var quakes = Quake.sampleQuakes
	@State var editMode: EditMode = .inactive
	@State var selectMode: SelectMode = .inactive
	@State var isLoading = false
	@State var selection: Set<String> = []
	
	var body: some View {
		NavigationStack {
			List(selection: $selection) {
				ForEach(quakes) { quake in
					QuakeRow(quake: quake)
				}
				.onDelete(perform: deleteQuakes)
			}
			.listStyle(.inset)
			.navigationTitle(title)
			.toolbar(content: toolbarContent)
			.environment(\.editMode, $editMode)
			.refreshable {
				fetchQuakes()
			}
		}
    }
}

extension Quakes {
	var title: String {
		if selectMode.isActive || selection.isEmpty {
			return "Earthquakes"
		} else {
			return "\(selection.count) Selected"
		}
	}
	
	func deleteQuakes(at offsets: IndexSet) {
		quakes.remove(atOffsets: offsets)
	}
	
	func deleteQuakes(for codes: Set<String>) {
		var offsetsToDelete: IndexSet = []
		for (index, element) in quakes.enumerated() {
			if codes.contains(element.code) {
				offsetsToDelete.insert(index)
			}
		}
		
		deleteQuakes(at: offsetsToDelete)
		selection.removeAll()
	}
	
	func fetchQuakes() {
		isLoading = true
		self.quakes = Quake.sampleQuakes
		lastUpdated = Date().timeIntervalSince1970
		isLoading = false
	}
}

#Preview {
    Quakes()
}
