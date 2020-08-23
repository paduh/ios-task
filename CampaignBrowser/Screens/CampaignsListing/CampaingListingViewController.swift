import UIKit
import RxSwift


/**
 The view controller responsible for listing all the campaigns. The corresponding view is the `CampaignListingView` and
 is configured in the storyboard (Main.storyboard).
 */
class CampaignListingViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet
    private(set) weak var typedView: CampaignListingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(typedView != nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        handeLoadCampaignList()
    }
    
    private func handeLoadCampaignList() {
        // Load the campaign list and display it as soon as it is available.
        ServiceLocator.instance.networkingService
            .createObservableResponse(request: CampaignListingRequest())
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (event) in
                guard let `self` =  self else { return }
                switch event {
                case .error(_):
                    self.typedView.displayError(delegate: self)
                case .next(let campaigns):
                    self.typedView.display(campaigns: campaigns)
                case .completed:
                    break
                }
        }.disposed(by: disposeBag)
    }
}

// CampaignErrorCellDelegate conformance for retry button action call
extension CampaignListingViewController: CampaignErrorCellDelegate {
    func didSelectRetry() {
        typedView.displayLoading()
        handeLoadCampaignList()
    }
}
