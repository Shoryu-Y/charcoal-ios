import CharcoalSwiftUI
import SwiftUI
import UIKit

public final class CharcoalModalController: UIViewController {
    private let titleText: String?
    private let message: String?

    public init(title: String?, message: String?) {
        titleText = title
        self.message = message

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var charcoalModalBodyHostingController = UIHostingController(rootView: CharcoalModalBody(
        title: titleText,
        style: .center,
        maxWidth: UIScreen.main.bounds.width - 48,
        bottomSafeAreaInset: 0,
        actions: {},
        modalContent: {
            if let message {
                Text(message)
                    .charcoalTypography16Regular()
                    .frame(maxWidth: .infinity)
            }
        }
    ))

    public var tapBackgroundToDismiss: Bool = false

    private var actions: [Action] = [] {
        didSet {
            charcoalModalBodyHostingController.rootView = CharcoalModalBody(
                title: titleText,
                style: .center,
                maxWidth: UIScreen.main.bounds.width - 48,
                bottomSafeAreaInset: 0,
                actions: {
                    ForEach(actions, id: \.title) { action in
                        Button { [weak self] in
                            if action.style == .cancel {
                                self?.dismiss(animated: true)
                            } else {
                                action.handler?()
                            }
                        } label: {
                            Text(action.title).frame(maxWidth: .infinity)
                        }
                        .actionButtonStyle(action.style)
                    }
                },
                modalContent: {
                    if let message {
                        Text(message)
                            .charcoalTypography16Regular()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            )
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackgroundViewTapped(_:))))

        addChild(charcoalModalBodyHostingController)
        charcoalModalBodyHostingController.didMove(toParent: self)

        charcoalModalBodyHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        charcoalModalBodyHostingController.view.backgroundColor = .clear
        view.addSubview(charcoalModalBodyHostingController.view)

        NSLayoutConstraint.activate([
            charcoalModalBodyHostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charcoalModalBodyHostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func onBackgroundViewTapped(_ sender: UITapGestureRecognizer) {
        if tapBackgroundToDismiss {
            dismiss(animated: true)
        }
    }
}

extension CharcoalModalController {
    public enum ActionStyle: Sendable {
        case primary
        case normal
        case destractive
        case cancel
    }

    public struct Action: Sendable {
        let title: String
        let style: ActionStyle
        let handler: (@Sendable () -> Void)?

        public init(title: String, style: ActionStyle, handler: (@Sendable () -> Void)? = nil) {
            self.title = title
            self.style = style
            self.handler = handler
        }
    }

    public func addAction(_ action: Action) {
        actions.append(action)
    }
}

private extension View {
    @ViewBuilder
    func actionButtonStyle(_ style: CharcoalModalController.ActionStyle) -> some View {
        switch style {
        case .normal, .cancel:
            self.charcoalDefaultButton()
        case .primary:
            self.charcoalPrimaryButton()
        case .destractive:
            self.charcoalPrimaryButton(primaryColor: Color(CharcoalAsset.ColorPaletteGenerated.assertive.color))
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    let viewController = CharcoalModalController(
        title: "ライブ機能終了のお知らせ",
        message: "ライブ機能は2025年7月dd日にサービスを終了します。保有ポイントの確認やご利用をお願いします。"
    )
    viewController.addAction(.init(
        title: "ポイントを確認", style: .primary, handler: {}
    ))
    viewController.addAction(.init(
        title: "詳しくみる", style: .normal, handler: {}
    ))

    return RootViewController()
}

@available(iOS 15, *)
final class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        var configuration = UIButton.Configuration.plain()
        configuration.title = "Tap"
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            .init { [weak self] _ in
                let viewController = CharcoalModalController(
                    title: "ライブ機能終了のお知らせ",
                    message: "ライブ機能は2025年7月dd日にサービスを終了します。保有ポイントの確認やご利用をお願いします。"
                )
                viewController.tapBackgroundToDismiss = true
                viewController.addAction(.init(
                    title: "ポイントを確認", style: .primary, handler: {}
                ))
                viewController.addAction(.init(
                    title: "詳しくみる", style: .normal, handler: {}
                ))

                viewController.modalPresentationStyle = .overFullScreen
                viewController.modalTransitionStyle = .crossDissolve

                self?.present(viewController, animated: true)
            },
            for: .touchUpInside
        )

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
