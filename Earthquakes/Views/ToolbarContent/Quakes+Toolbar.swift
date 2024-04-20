//
//  Quakes+Toolbar.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

extension QuakesView {
	@ToolbarContentBuilder
	func toolbarContent() -> some ToolbarContent {
		ToolbarItem(placement: .topBarLeading) {
			if editMode == .active {
				SelectButton(mode: $selectMode) {
					if selectMode.isActive {
						selection = Set(quakes.map { $0.code })
					} else {
						selection = []
					}
				}
			}
		}
		
		ToolbarItem(placement: .topBarTrailing) {
			EditButton(editMode: $editMode) {
				selection.removeAll()
				editMode = .inactive
				selectMode = .inactive
			}
		}
		
		ToolbarItemGroup(placement: .bottomBar) {
			RefreshButton {
				Task {
					fetchQuakes()
				}
			}
			Spacer()
			ToolbarStatus(isLoading: isLoading,
						  lastUpdated: lastUpdated,
						  quakesCount: quakes.count)
			Spacer()
			if editMode == .active {
				DeleteButton {
					deleteQuakes(for: selection)
				}
				.disabled(isLoading || selection.isEmpty)
			}
		}
	}
}
