//
//  ViewController.swift
//  ActivityViewController
//
//  Created by Maksim Vialykh on 2019-02-21.
//  Copyright © 2019 Vialyx. All rights reserved.
//

import UIKit

// MARK: - UIActivity.ActivityType
extension UIActivity.ActivityType {

    public static let clap = UIActivity.ActivityType(rawValue: "clap_clap")

}

// MARK: - UIActivity
final class ClapActivity: UIActivity {

    override class var activityCategory: Category { return .share }

    override var activityType:  ActivityType? { return .clap }
    override var activityTitle: String? { return "Clap! Clap!" }
    override var activityImage: UIImage? { return UIImage(named: "vialyx") }

    override var activityViewController: UIViewController? {
        let alert = UIAlertController(title: "Thank you!", message: "Keep in touch", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) {
            [unowned self] action in
            alert.dismiss(animated: true)
            self.activityDidFinish(true)
        })
        return alert
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }

}
// TODO: - Move to the separated file

// MARK: - ViewController
final class ViewController: UIViewController {

    let url   = URL(string: "https://medium.com/@vialyx")
    let image = UIImage(named: "AppIcon")

    override func loadView() {
        super.loadView()

        // Just create a demo button
        let actionB = UIButton(type: .custom)
        actionB.setTitle("UIActivityViewController", for: UIControl.State())
        actionB.backgroundColor = .red
        actionB.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        actionB.addTarget(self, action: #selector(shareDidTap), for: .touchUpInside)
        view.addSubview(actionB)
    }

    @objc private func shareDidTap() {
        let activityVC = UIActivityViewController(activityItems: [url, image],
                                                  applicationActivities: [ClapActivity()])
        activityVC.completionWithItemsHandler = {
            type, completed, items, error in
            print("""
                        type: \(type)
                        completed: \(completed)
                        items: \(items)
                        error: \(error)
                  """)
        }
        present(activityVC, animated: true)
    }

}
