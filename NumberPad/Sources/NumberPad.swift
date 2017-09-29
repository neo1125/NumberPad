import UIKit

public protocol NumberPadDelegate {
    func keyPressed(key: NumberKey?)
}

@IBDesignable open class NumberPad: UIView {

    open var delegate: NumberPadDelegate?
   
    @IBInspectable open var keyBackgroundColor: UIColor = defaultBackgroundColor {
        didSet { updateKeys() }
    }
    
    @IBInspectable open var keyHighlightColor: UIColor = defaultHighlightColor {
        didSet { updateKeys() }
    }
    
    @IBInspectable open var keyTitleColor: UIColor = .white {
        didSet { updateKeys() }
    }
    
    @IBInspectable open var keyBorderWidth: CGFloat = 0.0 {
        didSet { updateKeys() }
    }
    
    @IBInspectable open var keyBorderColor: UIColor = .clear {
        didSet { updateKeys() }
    }
    
    @IBInspectable open var keyScale: CGFloat = 1.0 {
        didSet { updateKeys() }
    }
    
    open var style: NumberPadStyle = .square {
        didSet { updateKeys() }
    }
    
    open var keyFont: UIFont? = UIFont(name: "AppleSDGothicNeo-Thin", size: 44) {
        didSet { updateKeys() }
    }
    
    open var clearKeyPosition: NumberClearKeyPosition = .right {
        didSet { updateKeys() }
    }
    
    open var clearKeyIcon: UIImage? = UIImage(named: "ic_backspace") {
        didSet { updateKeys() }
    }
    
    open var clearKeyBackgroundColor: UIColor = defaultBackgroundColor {
        didSet { updateKeys() }
    }
    
    open var clearKeyHighlightColor: UIColor = defaultHighlightColor {
        didSet { updateKeys() }
    }
    
    open var clearKeyTintColor: UIColor = .white {
        didSet { updateKeys() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateKeys()
    }
    
    @objc func keyEvent(sender: NumberKeyButton) {
        delegate?.keyPressed(key: sender.key)
    }
    
    private static let defaultBackgroundColor: UIColor = UIColor(white: 0, alpha: 0.6)
    private static let defaultHighlightColor: UIColor = UIColor(white: 0, alpha: 0.4)
    private final let rows: Int = 4
    private final let cols: Int = 3
    private var keys: [NumberKeyButton] = []
    
    private func setupViews() {
        clipsToBounds = true
        let width: CGFloat = bounds.width / CGFloat(cols)
        let height: CGFloat = bounds.height / CGFloat(rows)
        var keyNumber = 1
        for i in 1...rows {
            for j in 1...cols {
                let keyButton = NumberKeyButton(type: .custom)
                keyButton.frame = CGRect(x: CGFloat(j-1) * width, y: CGFloat(i-1) * height, width: width, height: height)
                keyButton.addTarget(self, action: #selector(keyEvent(sender:)), for: .touchUpInside)
                switch keyNumber {
                case 10:
                    keyButton.key = .empty
                case 11:
                    keyButton.key = .key0
                case 12:
                    keyButton.key = .clear
                default:
                    keyButton.key = NumberKey(rawValue: keyNumber)
                }
                keys.append(keyButton)
                self.addSubview(keyButton)
                keyNumber += 1
            }
        }
        updateKeys()
    }
    
    private func updateKeys() {
        
        for (index, button) in keys.enumerated() {
            if style == .circle && button.bounds.width != button.bounds.height {
                let frame = button.frame
                if button.bounds.width > button.bounds.height {
                    button.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.height, height: frame.size.height)
                } else {
                    button.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.width)
                }
            }
            
            if clearKeyPosition == .left {
                if index == 9 {
                    button.key = .clear
                }
                
                if index == 11 {
                    button.key = .empty
                }
            } else {
                if index == 9 {
                    button.key = .empty
                }
                
                if index == 11 {
                    button.key = .clear
                }
            }
            
            button.layer.cornerRadius = style == .square ? 0 : button.bounds.height / 2
            button.setScale(scale: keyScale)
            button.setBackgroundColor(color: keyBackgroundColor, forState: .normal)
            button.setBackgroundColor(color: keyHighlightColor, forState: .highlighted)
            button.setTitleColor(keyTitleColor, for: .normal)
            button.titleLabel?.font = keyFont
            button.layer.borderWidth = keyBorderWidth
            button.layer.borderColor = keyBorderColor.cgColor
            
            if button.key == .clear {
                button.setIcon(image: clearKeyIcon, color: clearKeyTintColor)
                button.setBackgroundColor(color: clearKeyBackgroundColor, forState: .normal)
                button.setBackgroundColor(color: clearKeyHighlightColor, forState: .highlighted)
            }
        }
    }
}
