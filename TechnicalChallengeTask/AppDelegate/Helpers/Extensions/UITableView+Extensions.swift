//
//  UITableView+Extensions.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
    
    func reloadDataWithAnimation(animation: CAMediaTimingFunctionName = .easeInEaseOut, duration: TimeInterval = 0.3, transition: CATransitionType = .push, transitionSubtype: CATransitionSubtype = .fromTop) {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name: animation)
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = duration
        transition.subtype = CATransitionSubtype.fromRight
        self.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
        self.reloadData()
    }
}
