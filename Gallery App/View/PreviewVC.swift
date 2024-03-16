//
//  PreviewVC.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import UIKit

class PreviewVC: UIViewController {
    
    private var pageController: UIPageViewController?
    var photosDetailsArray: [PhotosDetails] = []
    var currentIndex: Int = 0

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .lightGray
        
        self.setupPageController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Setup Page Controller
    
    private func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.pageController?.view.backgroundColor = .white
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        //self.addChild(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let initialVC = ImageVC(with: photosDetailsArray[currentIndex])
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)

    

        self.pageController?.didMove(toParent: self)
    }
}


extension PreviewVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? ImageVC else {
            return nil
        }
        
        var index = 0
        if let firstIndex = photosDetailsArray.firstIndex(where: { $0.id == currentVC.photosDetails.id }) {
            index = firstIndex
        }
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vc: ImageVC = ImageVC(with: photosDetailsArray[index])
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? ImageVC else {
            return nil
        }
        
        var index = 0
        if let firstIndex = photosDetailsArray.firstIndex(where: { $0.id == currentVC.photosDetails.id }) {
            index = firstIndex
        }
        
        if index >= self.photosDetailsArray.count - 1 {
            return nil
        }
        
        index += 1
        
        let vc: ImageVC = ImageVC(with: photosDetailsArray[index])
        
        return vc
    }

    
}

