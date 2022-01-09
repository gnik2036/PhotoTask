//
//  PhotosViewModel.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//
//
import UIKit


struct PhotosViewModelCalling {
    func getAPIData(param: [String: Any], completion: @escaping ([PhotoModel]?, ServiceError?) -> ()) {
        let request = PhotosAPI()

        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
}

protocol PhotosViewModelInputs {
    func fetchPhotos()
    func photoCellViewModel(atRow row: Int) -> PhotoCellViewModelProtocol
    func fetchMorePhotosIfAvailable(at row: Int)
    func adTitle(atRow row: Int) -> String
    
    func adRow(for indexPath: IndexPath) -> Int?
    func photoRow(for indexPath: IndexPath) -> Int?
    func didSelectRow(at indexPath: IndexPath)

}

protocol PhotosViewModelOutputs {
    var showLoading: ( (_ show: Bool) -> Void )? { get set }
    var reloadData: ( () -> Void )? { get set }
    var numberOfItems: Int { get }
    var failureAlert: ( (_ message: String) -> Void )? { get set }
    var showPhotoInFullScreen: ( (ItemDetailsViewModelProtocol) -> Void )? { get set }

}

protocol PhotosViewModelProtocol: AnyObject {
    var inputs: PhotosViewModelInputs { get }
    var outputs: PhotosViewModelOutputs { get set }
}

class PhotosViewModel: PhotosViewModelInputs, PhotosViewModelOutputs, PhotosViewModelProtocol {
    
    var inputs: PhotosViewModelInputs { self }
    var outputs: PhotosViewModelOutputs {
        get { self }
        set { }
    }
    var photoViewModelRequesting: PhotosViewModelCalling
//    private let provider: PicsumProviding
    private var photos: [PhotoModel] = []
    private var page: Int = 1
    private var isGettingPhotos: Bool = false
    private var didFetchLastPage: Bool = false
    private var isconnectedToInternet: Bool = true
    private var ads: [String] = []
    private let AD_INTERVAL = 6
    
    init() {
//        self.provider = provider
        self.photoViewModelRequesting = PhotosViewModelCalling()

        Monitor().startMonitoring { [weak self] isReachable in
            guard let self = self else { return }
            print("Is Connected To internet: \(isReachable)")
            self.isconnectedToInternet = isReachable
        }
    }
    
    /// Inputs
    
    func fetchPhotos(){
        guard isconnectedToInternet else {
            loadLocalPhotosDataIfExist()
            return
        }
        
        isGettingPhotos = true
        showLoading?(true)
        photoViewModelRequesting.getAPIData(param: ["limit" : 10,"page":page], completion: { (model, error) in
            if let errorA = error {
                DispatchQueue.main.async {
                    self.failureAlert?(errorA.message )
                }
            } else {
                if let modelUW = model {
                    self.handle(photos: modelUW)
                    self.prepareAdsData()
                    self.reloadData?()
                }
            }
            self.isGettingPhotos = false
            self.showLoading?(false)
            
        })
    }
    
    private func handle(photos: [PhotoModel]){
        // If photos returned as an empty array so we are at the last page.
        self.didFetchLastPage = photos.isEmpty
        
        if self.page == 1 { self.photos = photos }
        else { self.photos.append(contentsOf: photos) }
        
        if page == 1 || page == 2{
            self.storePhotosDataLocally()
        }
    }
    
    func photoCellViewModel(atRow row: Int) -> PhotoCellViewModelProtocol{
        PhotoCellViewModel(photo: photos[row])
    }
    
    /// Will Fetch More Data If This all the conditions is passed to avoid Fetching photos again and again.
    func fetchMorePhotosIfAvailable(at row: Int){
        guard isconnectedToInternet else { return }
        guard !isGettingPhotos else { return }
        guard (row + 1) == numberOfItems else { return }
        guard !didFetchLastPage else { return }
        page += 1
        self.fetchPhotos()
    }
    
    /// Preparing Ads data so that we can add an ad every 5 photos.
    func prepareAdsData(){
        var values = [String]()
        for _ in stride(from: 0, to: photos.count, by: self.AD_INTERVAL - 1) {
            values.append("Vodafone❤️" )
        }
        self.ads = values
    }
    
    /// Get the correct index for photo from the indexPath according to ad Interval
    func photoRow(for indexPath: IndexPath) -> Int? {
        let (quotient, remainder) = (indexPath.row + 1).quotientAndRemainder(dividingBy: AD_INTERVAL)
        if remainder == 0 { return nil }
        return quotient * (AD_INTERVAL - 1) + remainder - 1
    }
    
    /// Get the correct index for ad from the indexPath according to ad Interval
    func adRow(for indexPath: IndexPath) -> Int? {
        let (quotient, remainder) = (indexPath.row + 1).quotientAndRemainder(dividingBy: AD_INTERVAL)
        if remainder != 0 { return nil }
        return quotient - 1
    }
    
    func adTitle(atRow row: Int) -> String{ ads[row] }
    
    // TODO: Load photos when there is no internet connection.
    func loadLocalPhotosDataIfExist(){
        
    }
    
    // TODO: Saving 20 items of photos locally.
    func storePhotosDataLocally(){
        
    }
    func didSelectRow(at indexPath: IndexPath){
        guard let row = photoRow(for: indexPath) else { return }
        let viewModel = ItemDetailsViewModel(photo: photos[row])
        showPhotoInFullScreen?(viewModel)
    }
    
    /// OutPuts
    
    var showLoading: ( (_ show: Bool) -> Void )?
    var reloadData: ( () -> Void )?
    var numberOfItems: Int { photos.count + ads.count }
    var failureAlert: ((String) -> Void)?
    var showPhotoInFullScreen: ( (ItemDetailsViewModelProtocol) -> Void)?
}
