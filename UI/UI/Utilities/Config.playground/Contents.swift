import PlaygroundSupport
import UIKit
import UI
import Common
import Combine

// Load custom fonts into Playground
let regularFontUrl = Bundle.main.url(forResource: FontStyle.allerRegular.fileName, withExtension: "ttf")
let lightRegularFontUrl = Bundle.main.url(forResource: FontStyle.allerLightRegular.fileName, withExtension: "ttf")
let boldFontUrl = Bundle.main.url(forResource: FontStyle.allerBold.fileName, withExtension: "ttf")
CTFontManagerRegisterFontURLs([regularFontUrl, lightRegularFontUrl, boldFontUrl] as CFArray, .process, true, nil)

class MyViewController : UIViewController {
    
    var cancellables: Set<AnyCancellable> = []
    let inset: CGFloat = 20
    
    lazy var backgroundLabels: AnyPublisher<UILabel, Never> = {
        let labels = [UILabel](count: 4) { UILabel() }
        let colors = [UIColor.Background.primary, UIColor.Background.secondary,
                                 UIColor.Text.primary, UIColor.Text.secondary]
        let names = ["Background: Primary", "Background: Secondary",
                     "Text: Primary", "Text: Secondary"]
        return labels.publisher
            .zip(zip(colors, names).publisher)
            .map { (label, labelInfo) in
                label.backgroundColor = labelInfo.0
                label.font = UIFontMetrics.default.scaledFont(for: UIFont.regular)
                label.text = labelInfo.1
                label.setBorder()
                return label
        }.eraseToAnyPublisher()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        backgroundLabels
            .sink { [weak self] in self?.view.addSubview($0) }
            .store(in: &cancellables)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var y = inset
        backgroundLabels
            .sink { [weak self] in
                guard let self = self else { return }
                $0.sizeToFit()
                $0.frame = CGRect(x: self.inset, y: y, width: $0.width, height: $0.height)
                y += self.inset + 10
            }
            .store(in: &cancellables)
    }

}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
