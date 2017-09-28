import Foundation
import UIKit

class NumberKeyButton: UIButton {
    let animationDuration: TimeInterval = 0.3
    var key: NumberKey?
    private var backgroundColors: [UIControlState.RawValue: UIColor] = [:]
    private var originRect: CGRect = CGRect.zero
    private var originTintColor: UIColor?
    private var originHightlightColor: UIColor?
    
    override var isHighlighted: Bool {
        didSet {
            guard let color = self.backgroundColors[isHighlighted ? UIControlState.highlighted.rawValue : UIControlState.normal.rawValue] else {
                return
            }
            
            UIView.animate(withDuration: isHighlighted ? 0.0 : animationDuration,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.layer.backgroundColor = color.cgColor
                            if self.key == .clear {
                                self.tintColor = self.isHighlighted ? self.originHightlightColor : self.originTintColor
                            }
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let keyType = key else {
            return
        }
        
        isEnabled = keyType != .empty
        setTitle(keyType.value(), for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        contentHorizontalAlignment = .center
        titleLabel?.textAlignment = .center
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        backgroundColors[forState.rawValue] = color
        if forState == .normal {
            self.layer.backgroundColor = color.cgColor
        }
    }
    
    func setScale(scale: CGFloat) {
        guard scale < 1.0 else {
            originRect = frame
            return
        }
        let marginWidth: CGFloat = originRect.width - (originRect.width * scale)
        let marginHeight: CGFloat = originRect.height - (originRect.height * scale)
        let x: CGFloat = marginWidth/2
        let y: CGFloat = marginHeight/2
        let w: CGFloat = originRect.width - marginWidth
        let h: CGFloat = originRect.height - marginHeight
        frame = CGRect(x: originRect.origin.x + x, y: originRect.origin.y + y, width: w, height: h)
        guard layer.cornerRadius > 0 else {
            return
        }
        layer.cornerRadius = h/2
    }
    
    func setIcon(image: UIImage?) {
        setIcon(image: image, color: titleColor(for: .normal))
    }
    
    func setIcon(image: UIImage?, color: UIColor?) {
        guard let icon = image else {
            return
        }
        setImage(icon, for: .normal)
        setImage(icon, for: .highlighted)
        tintColor = color
        originHightlightColor = backgroundColors[UIControlState.highlighted.rawValue]
        originTintColor = tintColor
    }
}

extension UIColor {
    func convertImage() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setFillColor(self.cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}