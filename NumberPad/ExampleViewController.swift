import UIKit

class ExampleViewController: UITableViewController {

    var storyboards: [String] = ["BasicNumberPad", "CircleNumberPad", "StoryboardNumberPad"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyboards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = storyboards[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewName = storyboards[indexPath.row] as String?,
            let vc = UIStoryboard.viewController(identifier: viewName) as UIViewController? else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
