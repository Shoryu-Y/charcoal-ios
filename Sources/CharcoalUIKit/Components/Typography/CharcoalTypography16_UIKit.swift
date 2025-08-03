import UIKit

public class CharcoalTypography16: CharcoalTypographyLabel {
    override public var fontSize: CGFloat {
        return CGFloat(charcoalFoundation.typography.size.the16.fontSize)
    }

    override public var lineHeight: CGFloat {
        return CGFloat(charcoalFoundation.typography.size.the16.lineHeight)
    }
}

// 期待通りに文字は中央揃いになり、lineHeightも正しい
@available(iOS 17.0, *)
#Preview {
    let typography = CharcoalTypography16()
    typography.text = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    typography.numberOfLines = 0
    typography.isBold = true
    typography.textAlignment = .center
    return typography
}

// lineHeightは正しいが、文字が中央揃いにならない
@available(iOS 17.0, *)
#Preview {
    let typography = CharcoalTypography16()
    typography.text = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    typography.textAlignment = .center
    typography.numberOfLines = 0
    typography.isBold = true
    return typography
}

// 文字は中央揃いになるが、lineHeightが期待通りでない
@available(iOS 17.0, *)
#Preview {
    let label = UILabel()
    label.text = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    label.font = .boldSystemFont(ofSize: 16)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
}
