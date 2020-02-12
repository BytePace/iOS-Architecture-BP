//
//  ClassIdentifiable.swift
//
//  Created by Nikita Velichkin on 25/01/2020.
//  Copyright © 2020 Velichkin Nikita. All rights reserved.
//

import UIKit

// MARK: - UITableViewCell

extension UITableView {

    final func register<T: UITableViewCell>(cellType: T.Type) where T: ClassIdentifiable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseId)
    }

    final func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type = T.self, forIndexPath indexPath: IndexPath) -> T where T: ClassIdentifiable {
        guard
            let cell = dequeueReusableCell(withIdentifier: cellType.reuseId, for: indexPath) as? T
            else { fatalError(dequeueError(type: cellType)) }

        return cell
    }
}

// MARK: - UITableViewHeaderFooterView

extension UITableView {

    final func register<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: ClassIdentifiable {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseId)
    }

    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T where T: ClassIdentifiable {
        guard
            let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseId) as? T
            else { fatalError(dequeueError(type: viewType)) }

        return view
    }
}

// MARK: - Dequeue Error

extension UITableView {
    private func dequeueError<T: ClassIdentifiable>(type: T.Type) -> String {
        return """
        Failed to dequeue a cell with identifier \(type.reuseId) matching type \(type.self).
        Check that the reuseIdentifier is set properly and that you registered the cell beforehand
        """
    }
}
