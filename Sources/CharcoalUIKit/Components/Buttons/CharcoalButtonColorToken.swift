import UIKit

struct CharcoalButtonColorToken: Sendable {
    let textColor: UIColor
    let pressedTextColor: UIColor
    let enabledBackgroundColor: UIColor
    let pressedBackgroundColor: UIColor

    private init(
        textColor: UIColor,
        enabledBackgroundColor: UIColor,
        pressedOverlayColor: UIColor
    ) {
        self.textColor = textColor
        self.pressedTextColor = textColor.blend(overlay: pressedOverlayColor)
        self.enabledBackgroundColor = enabledBackgroundColor
        self.pressedBackgroundColor = enabledBackgroundColor.blend(overlay: pressedOverlayColor)
    }

    private init(
        textColor: UIColor,
        pressedTextColor: UIColor,
        backgroundColor: UIColor
    ) {
        self.textColor = textColor
        self.pressedTextColor = pressedTextColor
        self.enabledBackgroundColor = backgroundColor
        self.pressedBackgroundColor = backgroundColor
    }

    static let `default` = CharcoalButtonColorToken(
        textColor: CharcoalAsset.ColorPaletteGenerated.text2.color,
        enabledBackgroundColor: CharcoalAsset.ColorPaletteGenerated.surface3.color,
        pressedOverlayColor: CharcoalAsset.ColorPaletteGenerated.surface10.color
    )

    static let defaultOverlay = CharcoalButtonColorToken(
        textColor: CharcoalAsset.ColorPaletteGenerated.text5.color,
        enabledBackgroundColor: CharcoalAsset.ColorPaletteGenerated.surface4.color,
        pressedOverlayColor: CharcoalAsset.ColorPaletteGenerated.surface10.color
    )

    static let link = CharcoalButtonColorToken(
        textColor: CharcoalAsset.ColorPaletteGenerated.text1.color,
        pressedTextColor: CharcoalAsset.ColorPaletteGenerated.text3.color,
        backgroundColor: .clear
    )

    static let navigation = CharcoalButtonColorToken(
        textColor: CharcoalAsset.ColorPaletteGenerated.text5.color,
        enabledBackgroundColor: CharcoalAsset.ColorPaletteGenerated.surface6.color,
        pressedOverlayColor: CharcoalAsset.ColorPaletteGenerated.surface10.color
    )

    static let charcoalPrimary = CharcoalButtonColorToken(
        textColor: CharcoalAsset.ColorPaletteGenerated.text5.color,
        enabledBackgroundColor: CharcoalAsset.ColorPaletteGenerated.brand.color,
        pressedOverlayColor: CharcoalAsset.ColorPaletteGenerated.surface10.color
    )

    static func primary(_ color: UIColor) -> CharcoalButtonColorToken {
        .init(
            textColor: CharcoalAsset.ColorPaletteGenerated.text5.color,
            enabledBackgroundColor: color,
            pressedOverlayColor: CharcoalAsset.ColorPaletteGenerated.surface10.color
        )
    }
}
