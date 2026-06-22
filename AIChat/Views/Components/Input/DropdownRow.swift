//
//  DropdownRow.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - DropdownRow

struct DropdownRow: View {

    // MARK: - Properties

    @Binding var isPresented: Bool
    let label: String
    let value: String

    // MARK: - Body

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Text(label)
                    .font(.regular16)

                Spacer()

                Text(value)
                    .font(.regular16)
            }
            .padding(.horizontal, 16)
            .frame(height: 60)
            .background(Color(.card))
            .clipShape(.rect(cornerRadius: 24))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    DropdownRow(
        isPresented: .constant(true),
        label: "Hello",
        value: "value"
    )
}
