import UIKit


/**
 The view which displays the list of campaigns. It is configured in the storyboard (Main.storyboard). The corresponding
 view controller is the `CampaignsListingViewController`.
 */
class CampaignListingView: UICollectionView {
    
    /**
     A strong reference to the view's data source. Needed because the view's dataSource property from UIKit is weak.
     */
    @IBOutlet var strongDataSource: UICollectionViewDataSource!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCells()
    }
    
    /**
        Handles the setup/registration of cells
     */
    
    private func setupCells() {
        self.register(CampaignErrorCell.self)
        self.register(CampaignCell.self)
        self.register(LoadingIndicatorCell.self)
    }

    /**
     Displays the given campaign list.
     */
    func display(campaigns: CampaignList) {
        handleSetup(dataSource: ListingDataSource(campaigns: campaigns))
    }
    
    /**
     Displays loading indicator cell.
     */
    func displayLoading() {
        handleSetup(dataSource: LoadingDataSource())
    }

    /**
     Displays error cell.
     */
    func displayError(delegate: CampaignErrorCellDelegate) {
        handleSetup(dataSource: ErrorDataSource(delegate: delegate))
    }

    private func handleSetup<T>(dataSource: T) where T: UICollectionViewDataSource, T: UICollectionViewDelegate {
        self.dataSource = dataSource
        delegate = dataSource
        strongDataSource = dataSource
        reloadData()
    }
}


/**
 The data source for the `CampaignsListingView` which is used to display the list of campaigns.
 */
class ListingDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    /** The campaigns that need to be displayed. */
    let campaigns: [Campaign]

    /**
     Designated initializer.

     - Parameter campaign: The campaigns that need to be displayed.
     */
    init(campaigns: [Campaign]) {
        self.campaigns = campaigns
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campaigns.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let campaign = campaigns[indexPath.item]
        let campaignCell = collectionView.dequeue(CampaignCell.self, for: indexPath)
        campaignCell.moodImage = campaign.moodImage
        campaignCell.name = campaign.name
        campaignCell.descriptionText = campaign.description
        return campaignCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 450)
    }

}



/**
 The data source for the `CampaignsListingView` which is used while the actual contents are still loaded.
 */
class LoadingDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeue(LoadingIndicatorCell.self, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}


/**
 This is the data source for the `CampaignsListingView` that is used when an error occurs
 */
  class ErrorDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  
    var delegate: CampaignErrorCellDelegate?
    /**
     Initializer.
     - Parameter CampaignErrorCellDelegate
     */
    init(delegate: CampaignErrorCellDelegate) {
        self.delegate = delegate
    }
        

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CampaignErrorCell.self, for: indexPath)
        cell.delegate = delegate
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
