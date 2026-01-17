//
//  FocusButton.swift // File name
//
//  A reusable, configurable button style and helper views for consistent buttons across the app. // Purpose of file
//
//  Created by Assistant on 1/16/26. // Author and creation date
//

import SwiftUI // Import SwiftUI for building declarative UI

/// A configurable button style that can represent both primary (full-width) and compact variants.
/// Using one style with parameters reduces duplication while allowing preset convenience wrappers.
struct FocusButtonStyle: ButtonStyle { // Single style replacing separate primary/compact styles
    // MARK: - Appearance parameters (tweak to create variants)
    var cornerRadius: CGFloat // Corner radius for the background shape
    var background: Color // Background color
    var foreground: Color // Foreground (text/icon) color
    var pressedOpacity: Double // Opacity while pressed for tap feedback
    var horizontalPadding: CGFloat // Horizontal padding inside the button
    var verticalPadding: CGFloat // Vertical padding inside the button
    var font: Font // Font used for the label
    var maxWidth: CGFloat? // Max width for the label; use .infinity for full-width, or nil to be intrinsic

    func makeBody(configuration: Configuration) -> some View { // Build the styled button body
        configuration.label // The content (label) provided by the caller
            .font(font) // Apply configured font
            .foregroundStyle(foreground) // Apply foreground color to text/icons
            .frame(maxWidth: maxWidth) // Control width behavior (full-width vs. intrinsic)
            .padding(.vertical, verticalPadding) // Vertical padding inside the button
            .padding(.horizontal, horizontalPadding) // Horizontal padding inside the button
            .background( // Background shape and fill
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous) // Smooth rounded rectangle
                    .fill(background) // Fill with the background color
            )
            .opacity(configuration.isPressed ? pressedOpacity : 1.0) // Visual feedback when pressed
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed) // Animate press/release transitions
    }
}

// MARK: - Presets to avoid repeating parameters in call sites
extension FocusButtonStyle { // Provide convenient factory presets for common variants
    /// Full-width primary preset (e.g., for "Create Rule").
    static var primary: FocusButtonStyle {
        FocusButtonStyle(
            cornerRadius: 20, // Rounded corners
            background: .accentColor, // Accent background
            foreground: .white, // White foreground
            pressedOpacity: 0.85, // Slight fade when pressed
            horizontalPadding: 50, // Generous horizontal padding
            verticalPadding: 12, // Comfortable vertical padding
            font: .headline, // Prominent label font
            maxWidth: .infinity // Full-width expansion
        )
    }

    /// Compact preset (intrinsic width; good for inline/toolbar usage).
    static var compact: FocusButtonStyle {
        FocusButtonStyle(
            cornerRadius: 14, // Slightly smaller corners
            background: .accentColor, // Accent background
            foreground: .white, // White foreground
            pressedOpacity: 0.85, // Slight fade when pressed
            horizontalPadding: 16, // Smaller horizontal padding
            verticalPadding: 8, // Smaller vertical padding
            font: .subheadline, // Smaller label font
            maxWidth: nil // No forced expansion; stays compact
        )
    }
}

/// A convenience wrapper that creates a button with the primary (full-width) preset.
/// Use this for common primary actions like "Create Rule" to keep consistency.
struct FocusButton: View { // A reusable SwiftUI view wrapping Button with our style
    let title: String // The text shown in the button
    let action: () -> Void // The action executed when the button is tapped

    init(title: String, action: @escaping () -> Void) { // Explicit initializer for clarity
        self.title = title // Store the title
        self.action = action // Store the action closure
    }

    var body: some View { // View body describing the UI
        Button(action: action) { // Standard SwiftUI Button
            Text(title) // Display the provided title as the label
                .bold() // Emphasize the label text
        }
        .buttonStyle(.primaryFocus) // Apply the primary preset via a custom ButtonStyleConfiguration
    }
}

/// Convenience wrapper for the compact (intrinsic width) preset.
struct FocusCompactButton: View { // Reusable view wrapping a Button with compact preset
    let title: String // The text shown in the button
    let action: () -> Void // The action executed when tapped

    init(title: String, action: @escaping () -> Void) { // Explicit initializer for clarity
        self.title = title // Store title
        self.action = action // Store action
    }

    var body: some View { // Describe the view
        Button(action: action) { // Standard SwiftUI Button
            Text(title) // Use text as the label
                .bold() // Emphasize label
        }
        .buttonStyle(.compactFocus) // Apply the compact preset via a custom ButtonStyleConfiguration
    }
}

// MARK: - Type-safe aliases for presets to keep call sites clean
extension ButtonStyle where Self == FocusButtonStyle { // Enable .buttonStyle(.primaryFocus) syntax
    static var primaryFocus: FocusButtonStyle { .primary } // Alias to primary preset
    static var compactFocus: FocusButtonStyle { .compact } // Alias to compact preset
}

#Preview("Focus Buttons") { // Xcode preview to visualize styles during development
    VStack(spacing: 16) { // Stack previews vertically with spacing
        // Primary (full-width) examples
        FocusButton(title: "Create Rule") {} // Example of the primary action we want to emulate
        Button("Primary via Style") {} // Example using the primary style directly on a Button
            .buttonStyle(.primaryFocus) // Apply the primary preset directly

        // Compact (intrinsic width) examples
        FocusCompactButton(title: "Create Rule") {} // Compact helper view example
        Button("Compact via Style") {} // Example using the compact style directly
            .buttonStyle(.compactFocus) // Apply the compact preset directly

        // Demonstrate custom parameterization inline (optional override)
        Button("Custom Width 400") {} // Button with custom max width
            .buttonStyle(FocusButtonStyle(
                cornerRadius: 20,
                background: .accentColor,
                foreground: .white,
                pressedOpacity: 0.85,
                horizontalPadding: 24,
                verticalPadding: 12,
                font: .headline,
                maxWidth: 400 // Limit width to 400pt
            ))
    }
    .padding() // Add padding around the preview content
}
