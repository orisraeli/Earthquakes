//
//  SelectButton.swift
//  Earthquakes
//
//  Created by Or Israeli on 19/04/2024.
//

import SwiftUI

enum SelectMode {
	case active, inactive
	
	var isActive: Bool {
		self == .active
	}
	
	mutating func toggle() {
		switch self {
			case .active:
				self = .inactive
			case .inactive:
				self = .active
		}
	}
}

struct SelectButton: View {
	@Binding var mode: SelectMode
	var action: () -> Void = {}
	
    var body: some View {
		Button {
			withAnimation {
				mode.toggle()
				action()
			}
		} label: {
			Text(mode.isActive ? "Deselect All" : "Select All")
		}
    }
}

#Preview {
	Group {
		SelectButton(mode: .constant(.active))
		SelectButton(mode: .constant(.inactive))
	}
}
