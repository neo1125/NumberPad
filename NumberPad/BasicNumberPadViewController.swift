import UIKit

class BasicNumberPadViewController: UIViewController {
    
    @IBOutlet var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numberPad = NumberPad(frame: CGRect(x: 0, y: 150, width: self.view.bounds.width, height: self.view.bounds.height - 150))
        numberPad.delegate = self
        numberPad.clearKeyPosition = .left
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
        default:
            textfield.text?.append("\(number.rawValue)")
        }
    }
}
