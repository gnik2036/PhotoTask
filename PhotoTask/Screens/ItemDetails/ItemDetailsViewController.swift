//
//  PhotoDetailsViewController.swift
//  iOS Assessment
//
//  Created by Ghalaab on 09/10/2021.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!

    
    // MARK: Properties
    
    var viewModel: ItemDetailsViewModelProtocol!
    
    // MARK: - View controller lifecycle methods

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        addTapGesture()
    }
    
    // MARK: - Configuration methods
    
    // Adding Tap Gesture in order to Open author Profile.
    private func addTapGesture(){
        self.photoImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapOpenProfile))
        photoImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTapOpenProfile() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func setupData(){
        
        self.photoImageView.sd_setImage(with: URL(string: viewModel.photoUrl))
        photoImageView.frame = UIScreen.main.bounds
        photoImageView.backgroundColor = .black


    }
}
