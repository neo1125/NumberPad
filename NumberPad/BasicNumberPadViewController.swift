import UIKit

class BasicNumberPadViewController: UIViewController {
    
    @IBOutlet var textfield: UITextField!
    
    private lazy var numberPad: NumberPad = {
        let pad = NumberPad()
        pad.delegate = self
        pad.clearKeyPosition = .left
        pad.customKeyText = "입력"
        pad.customKeyTitleColor = UIColor.white
        pad.backgroundColor = .white
        pad.keyBorderColor = UIColor.white
        pad.keyBorderWidth = 1
        pad.keyScale = 0.8
        pad.style = .circle
        
        if #available(iOS 11.0, *) {
            pad.customKeyBackgroundColor = UIColor(named: "CustomKeyBackground")
            pad.customKeyHighlightColor = UIColor(named: "CustomKeyHighlight")
            pad.customKeyBorderColor = UIColor(named: "CustomKeyBackground")
            pad.customKeyBorderWidth = 1
        } else {
            pad.customKeyBackgroundColor = UIColor(red: 0.203, green: 0.594, blue: 0.859, alpha: 1)
            pad.customKeyHighlightColor = UIColor(red: 0.214, green: 0.651, blue: 0.941, alpha: 1)
            pad.customKeyBorderColor = UIColor(red: 0.203, green: 0.594, blue: 0.859, alpha: 1)
            pad.customKeyBorderWidth = 1
        }
        return pad
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(numberPad)
        
        view.addConstraints(withFormat: "H:|[v0]|", views: numberPad)
        view.addConstraints(withFormat: "V:|-200-[v0]|", views: numberPad)
    }
}

extension BasicNumberPadViewController: NumberPadDelegate {
    func keyPressed(key: NumberKey?) {
        guard let number = key else {
            return
        }
        switch number {
        case .clear:
            guard !(textfield.text?.isEmpty ?? true) else {
                return
            }
            textfield.text?.removeLast()
        case .custom:
            let alert = UIAlertController(title: "Custom NumberPad Event",
                                          message: "\(textfield.text ?? "") Send Number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        default:
            textfield.text?.append("\(number.rawValue)")
        }
    }
}
