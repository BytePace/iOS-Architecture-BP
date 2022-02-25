//
//  UITableView+ClassIdentifiable.swift
//  BytepaceSwiftUtils
//
//  Created by Semen Ilin on 05.05.2021.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) where T: ClassIdentifiable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseId)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: ClassIdentifiable {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseId)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withCellType type: T.Type = T.self) -> T where T: ClassIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseId) as? T else { fatalError(dequeueError(withIdentifier: type.reuseId, type: self)) }
        
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>( //swiftlint:disable:this function_default_parameter_at_end
        withCellType type: T.Type = T.self,
        forIndexPath indexPath: IndexPath) -> T where T: ClassIdentifiable {
        guard let cell = dequeueReusableCell(
                withIdentifier: type.reuseId,
                for: indexPath) as? T
        else {
            fatalError(dequeueError(withIdentifier: type.reuseId, type: self))
        }
        
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withViewType type: T.Type) -> T where T: ClassIdentifiable {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: type.reuseId) as? T
        else { fatalError(dequeueError(withIdentifier: type.reuseId, type: self)) }
        return headerFooterView
    }
}

