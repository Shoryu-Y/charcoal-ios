import SwiftUI

public struct CharcoalModalBody: View {
    /// The title of the modal view.
    var title: String?
    /// The style of the modal view.
    var style: CharcoalModalStyle
    /// The max width of the modal view.
    let maxWidth: CGFloat
    /// hoge
    let bottomSafeAreaInset: CGFloat
    /// The content of the action view
    private let actions: (any View)?
    /// The content of the modal view
    private let modalContent: any View

    /// The bottom inset of the safe area.
    @State private var indicatorInset: CGFloat = .zero

    public init(
        title: String? = nil,
        style: CharcoalModalStyle,
        maxWidth: CGFloat,
        bottomSafeAreaInset: CGFloat,
        @ViewBuilder actions: () -> (some View)?,
        @ViewBuilder modalContent: () -> some View
    ) {
        self.title = title
        self.style = style
        self.maxWidth = maxWidth
        self.bottomSafeAreaInset = bottomSafeAreaInset
        self.actions = actions()
        self.modalContent = modalContent()
    }

    public var body: some View {
        VStack(spacing: 0) {
            if let title = title {
                Text(title).charcoalTypography20Bold(isSingleLine: true)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            }

            AnyView(modalContent)

            if let actions = actions {
                VStack {
                    AnyView(actions)
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: style == .center ? 20 : indicatorInset, trailing: 20))
                .onAppear {
                    indicatorInset = max(bottomSafeAreaInset, 30)
                }
            }
        }
        .frame(minWidth: 280, maxWidth: maxWidth)
        .background(Rectangle().cornerRadius(32, corners: style.roundedCorners).foregroundStyle(charcoalColor: .surface1))
    }
}
