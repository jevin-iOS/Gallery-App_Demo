//
//  PhotosViewModel.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation

struct PhotosViewModel {
    
    var indicatorActivity: Observable<Bool> = Observable(value: true)
    var gettingError: Observable<(String, String)> = Observable(value: nil)
    var photosData: Observable<[PhotosDetails]> = Observable(value: nil)
    
    func fetchPhotosList() {
        
        let photosResource = PhotosResource()
        
        indicatorActivity.value = false
        photosResource.fetchPhotosData { photosApiResponse in
            if let photosApiResponse = photosApiResponse {
                photosData.value = photosApiResponse
            } else {
                gettingError.value = (StaticErrorMessages.title.stringValue, StaticErrorMessages.message.stringValue)
            }
            indicatorActivity.value = true
        }
    }
}
