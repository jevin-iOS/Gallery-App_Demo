//
//  PhotosResource.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation

struct PhotosResource {
    
    func fetchPhotosData(response: @escaping ((PhotosResponse?)->())) {
        
        if let apiUrl = makeRequestUrl() {
            let httpUtility = HttpUtility()
            
            httpUtility.getApiData(requestUrl: apiUrl, resultType: PhotosResponse.self) { result in
                response(result)
            }
        } else {
            response(nil)
        }
    
    }
    
    private func makeRequestUrl() -> URL? {
        return URL(string: "\(ApiEndpoints.photosList)?client_id=\(CLIENT_ID)&order_by=ORDER&per_page=150")
    }
}
