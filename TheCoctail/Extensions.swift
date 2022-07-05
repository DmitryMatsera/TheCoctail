//
//  Extensions.swift
//  TheCoctail
//
//  Created by Дмитрий Мацера on 02.07.2022.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionReusableView: ReusableView {}

extension UICollectionView {
    func registerClassCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableTypedCell<T: UICollectionViewCell>(for indexPath: IndexPath,
                                                           cellType _: T.Type) -> T {
        let identifier = T.reuseIdentifier
        let dequeuedCell = dequeueReusableCell(withReuseIdentifier: identifier,
                                               for: indexPath)

        guard let cell = dequeuedCell as? T else {
            fatalError("Could not dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
}


extension UITableViewCell: ReusableView {}

public extension UITableView {
    func registerClassCell<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableTypedCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                      cellType _: T.Type) -> T {
        let identifier = T.reuseIdentifier
        let dequeuedCell = dequeueReusableCell(withIdentifier: identifier,
                                               for: indexPath)

        guard let cell = dequeuedCell as? T else {
            fatalError("Could not dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
}

infix operator ~>
public func ~><T> (lhs: T, rhs: (T) -> Void) -> T where T: AnyObject {
    rhs(lhs)
    return lhs
}

extension NSError {
    convenience init(_ errorString: String, _ errorCode: Int) {
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: errorString]
        self.init(domain: "Coctails", code: errorCode, userInfo: userInfo)
    }
}
