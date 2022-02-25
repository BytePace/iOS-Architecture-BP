//
//  UITableView+ClassIdentifiable.swift
//  BytepaceSwiftUtils
//
//  Created by Semen Ilin on 05.05.2021.
//

import UIKit

public extension UICollectionView {
    func register<C: UICollectionViewCell>(cellType: C.Type) where C: ClassIdentifiable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
    }
    
    func dequeueReusableCell<C: UICollectionViewCell>( //swiftlint:disable:this function_default_parameter_at_end
        withCellType type: C.Type = C.self,
        forIndexPath indexPath: IndexPath) -> C where C: ClassIdentifiable {
        guard let cell = dequeueReusableCell(
                withReuseIdentifier: type.reuseId,
                for: indexPath) as? C
        else {
            fatalError(dequeueError(withIdentifier: type.reuseId, type: self))
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryView<C: UICollectionReusableView>( //swiftlint:disable:this function_default_parameter_at_end
        withViewType type: C.Type = C.self,
        ofKind kind: String,
        forIndexPath indexPath: IndexPath) -> C where C: ClassIdentifiable {
        guard let view = dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: type.reuseId,
                for: indexPath) as? C
        else {
            fatalError(dequeueError(withIdentifier: type.reuseId, type: self))
        }
        
        return view
    }
}

