//
//  PhotoListViewController.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//

import UIKit

class PhotoListViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var photosTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: Properties
    
    let viewModel: PhotosViewModelProtocol = PhotosViewModel()
    var photosDataSource: PhotosDataSource!
    var photosDelegate: PhotosDelegate!
    
    // MARK: - View controller lifecycle methods

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfigurations()
        binding()
        viewModel.inputs.fetchPhotos()
    }
    
    // MARK: - Configuration methods

    /// Configure Data source for photos table view.
    func tableViewConfigurations(){
        self.photosDataSource = PhotosDataSource(viewModel: self.viewModel)
        self.photosTableView.dataSource = photosDataSource
        
        self.photosDelegate = PhotosDelegate(viewModel: self.viewModel)
        self.photosTableView.delegate = photosDelegate

        self.photosTableView.estimatedRowHeight = UITableView.automaticDimension
        self.photosTableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: PhotoTableViewCell.identifier, bundle: nil)
        self.photosTableView.register(nib, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        let adNib = UINib(nibName: AdTableViewCell.identifier, bundle: nil)
        self.photosTableView.register(adNib, forCellReuseIdentifier: AdTableViewCell.identifier)
    }
    
    /// Binind all changes that could happen in the view model.
    func binding(){
        viewModel.outputs.reloadData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.photosTableView.reloadData()
            }
        }
        
        viewModel.outputs.failureAlert = { [weak self] message in
            guard let self = self else { return }
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
        
        viewModel.outputs.showLoading = { [weak self] shouldShow in
            guard let self = self else { return }
            if shouldShow{
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.stopAnimating()
                }
            }
        }
        viewModel.outputs.showPhotoInFullScreen = { [weak self] detailsViewModel in
            guard let self = self else { return }
            let newController = ItemDetailsViewController.instantiate(from: .main)
//            newController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            newController.viewModel = detailsViewModel
            self.present(newController, animated: true, completion: nil)
        }
    }
    
}




