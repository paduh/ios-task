//
//  UICollectionView+Extension.swift
//  CampaignBrowser
//
//  Created by Aduh Perfect on 23/08/2020.
//  Copyright © 2020 Westwing GmbH. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let reuseId = reuseIdentifier ?? "\(T.self)"
        self.register(UINib(nibName: reuseId, bundle: Bundle.main), forCellWithReuseIdentifier: reuseId)
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not dequeue cell with type \(T.self)") }
        
        return cell
    }
}

