import UIKit

class StoryboardNumberPadViewController: UIViewController {

    @IBOutlet var textfield: UITextField!
    @IBOutlet var numberPad: NumberPad!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberPad.style = .circle
        numberPad.clearKeyBackgroundColor = .clear
        numberPad.clearKeyHighlightColor = .clear
        numberPad.clearKeyTintColor = .red
        numberPad.keyScale = 0.8
        numberPad.delegate = self
    }
}

extension StoryboardNumberPadViewController: NumberPadDelegate {
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
