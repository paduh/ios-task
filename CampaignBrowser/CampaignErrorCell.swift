//
//  CampaignErrorCell.swift
//  CampaignBrowser
//
//  Created by Aduh Perfect on 23/08/2020.
//  Copyright © 2020 Westwing GmbH. All rights reserved.
//

import UIKit

protocol CampaignErrorCellDelegate {
    
    func didSelectRetry()
}

// The cell which displays when an error occurs with a button to retry
class CampaignErrorCell: UICollectionViewCell {
    
     /** Used to retry to get campaign list if when an error occurs. */
    @IBOutlet weak var retryBtn: UIButton!

    var delegate: CampaignErrorCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRetryBtn()
    }
    
    //  Handles the setup of the retry button
    private func setupRetryBtn() {
        retryBtn.addTarget(self, action: #selector(handleRetry), for: .touchUpInside)
    }

    // Used to send the action of the retry button to the delegatee
    @objc func handleRetry() {
        delegate?.didSelectRetry()
    }
}
