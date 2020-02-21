//
//  ClassIdentifiable.swift
//
//  Created by Nikita Velichkin on 25/01/2020.
//  Copyright © 2020 Velichkin Nikita. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewCell

extension UICollectionView {
    
    func register<C: UICollectionViewCell>(cellType: C.Type) where C: ClassIdentifiable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
    }

    func dequeueReusableCell<C: UICollectionViewCell>(_ cellType: C.Type = C.self, forIndexPath indexPath: IndexPath) -> C where C: ClassIdentifiable {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? C
            else { fatalError(dequeueError(type: cellType)) }

        return cell
    }
}

// MARK: - UICollectionReusableView

extension UICollectionView {

    enum SupplymentaryViewKind {
        case header
        case footer

        var identifier: String {
            switch self {
            case .header:
                return elementKindSectionHeader
            case .footer:
                return elementKindSectionFooter
            }
        }
    }

    func registerView<C: UICollectionReusableView>(ofKind kind: SupplymentaryViewKind, viewType: C.Type) where C: ClassIdentifiable {
        register(viewType.self, forSupplementaryViewOfKind: kind.identifier, withReuseIdentifier: viewType.reuseId)
    }

    func dequeueReusableView<C: UICollectionReusableView>(ofKind kind: SupplymentaryViewKind, _ viewType: C.Type = C.self, forIndexPath indexPath: IndexPath) -> C where C: ClassIdentifiable {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind.identifier, withReuseIdentifier: viewType.reuseId, for: indexPath) as? C
            else { fatalError(dequeueError(type: viewType)) }

        return view
    }
}

// MARK: - Dequeue Error

extension UICollectionView {
    private func dequeueError<T: ClassIdentifiable>(type: T.Type) -> String {
        return """
        Failed to dequeue a cell with identifier \(type.reuseId) matching type \(type.self).
        Check that the reuseIdentifier is set properly and that you registered the cell beforehand
        """
    }
}
