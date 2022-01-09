//
//  PhotosViewModel.swift
//  PhotoTask
//
//  Created by Mohammed Hassan on 08/01/2022.
//

struct PhotosViewModel {
    func getAPIData(param: [String: Any], completion: @escaping (PhotoModel?, ServiceError?) -> ()) {
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
