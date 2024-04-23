//
//  QuakesView.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

struct QuakesView: View {
	@AppStorage("lastUpdated")
	var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
	@EnvironmentObject var provider: QuakesProvider
	@State var editMode: EditMode = .inactive
	@State var selectMode: SelectMode = .inactive
	@State var isLoading = false
	@State var selection: Set<String> = []
	@State private var error: QuakeError?
	@State private var hasError = false
	
	var body: some View {
		NavigationStack {
			List(selection: $selection) {
				ForEach(provider.quakes) { quake in
					NavigationLink(destination: QuakeDetail(quake: quake)) {
						QuakeRow(quake: quake)
					}
				}
				.onDelete(perform: deleteQuakes)
			}
			.listStyle(.inset)
			.navigationTitle(title)
			.toolbar(content: toolbarContent)
			.environment(\.editMode, $editMode)
			.refreshable {
				await fetchQuakes()
			}
			.alert(isPresented: $hasError, error: error) { }
		}
		.task {
			await fetchQuakes()
		}
    }
}

extension QuakesView {
	var title: String {
		if selectMode.isActive || selection.isEmpty {
			return "Earthquakes"
		} else {
			return "\(selection.count) Selected"
		}
	}
	
	func deleteQuakes(at offsets: IndexSet) {
		provider.deleteQuakes(atOffsets: offsets)
	}
	
	func deleteQuakes(for codes: Set<String>) {
		var offsetsToDelete: IndexSet = []
		for (index, element) in provider.quakes.enumerated() {
			if codes.contains(element.code) {
				offsetsToDelete.insert(index)
			}
		}
		
		deleteQuakes(at: offsetsToDelete)
		selection.removeAll()
	}
	
	func fetchQuakes() async {
		isLoading = true
		do {
			try await provider.fetchQuakes()
			lastUpdated = Date().timeIntervalSince1970
		} catch {
			self.error = error as? QuakeError ?? .unexpectedError(error: error)
			self.hasError = true
		}
		isLoading = false
	}
}

#Preview {
    QuakesView()
		.environmentObject(QuakesProvider(client: QuakeClient(downloader: TestDownloader())))
}
