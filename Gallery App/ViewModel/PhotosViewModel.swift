//
//  PhotosViewModel.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation

struct PhotosViewModel {
    
    var gettingError: Observable<(String, String)> = Observable(value: nil)
    var photosData: Observable<[PhotosDetails]> = Observable(value: nil)
    
    func fetchPhotosList() {
        
        let photosResource = PhotosResource()
        
        photosResource.fetchPhotosData { photosApiResponse in
            if let photosApiResponse = photosApiResponse {
                photosData.value = photosApiResponse
            } else {
                gettingError.value = (StaticErrorMessages.title.stringValue, StaticErrorMessages.message.stringValue)
            }
        }
    }
    
    func removePhotosDetails(ids: [String]) {
        
        var photosDetailsArray: [PhotosDetails] = photosData.value ?? []
        
        for id in ids {
            photosDetailsArray.removeAll { $0.id == id }
        }
        
        photosData.value = photosDetailsArray
    }
}
