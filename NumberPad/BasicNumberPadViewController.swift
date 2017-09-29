import UIKit

class BasicNumberPadViewController: UIViewController {
    
    @IBOutlet var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numberPad = NumberPad(frame: CGRect(x: 0, y: 150, width: self.view.bounds.width, height: self.view.bounds.height - 150))
        numberPad.delegate = self
        numberPad.clearKeyPosition = .left
        numberPad.customKeyText = "입력"
        numberPad.customKeyTitleColor = UIColor.white
        if #available(iOS 11.0, *) {
            numberPad.customKeyBackgroundColor = UIColor(named: "CustomKeyBackground")
            numberPad.customKeyHighlightColor = UIColor(named: "CustomKeyHighlight")
        } else {
            numberPad.customKeyBackgroundColor = UIColor(red: 0.203, green: 0.594, blue: 0.859, alpha: 1)
            numberPad.customKeyHighlightColor = UIColor(red: 0.214, green: 0.651, blue: 0.941, alpha: 1)
        }
        self.view.addSubview(numberPad)
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
