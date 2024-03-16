//
//  ViewController.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import UIKit

class PhotosVC: UIViewController {

    @IBOutlet weak var btnSelectUnSelect: UIButton!
    @IBOutlet weak var btnGridList: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var photosTable: UITableView!
    @IBOutlet weak var photosCollection: UICollectionView!
    
    var isSelectionOn: Bool = false
    var isGridOn: Bool = false
    var selectedPhotosIds: [String] = []
    
    lazy var photosViewModel: PhotosViewModel = {
       return PhotosViewModel()
    }()
    
    private var photosTableDataSource: PhotosTableDataSource<ListViewCell, PhotosDetails>?
    private var photosTableTableDelegate = PhotosTableTableDelegate<PhotosDetails>()
    
    private var photosCollectionDataSource: PhotosCollectionDataSource<GridViewCell, PhotosDetails>?
    private var photosCollectionDelegate = PhotosCollectionDelegate<PhotosDetails>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        photosTable.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
        photosTable.delegate = photosTableTableDelegate
        
        photosCollection.register(UINib(nibName: "GridViewCell", bundle: nil), forCellWithReuseIdentifier: "GridViewCell")
        photosCollection.delegate = photosCollectionDelegate
        
        self.addIndicatorEvent()
        self.fetchPhotosList()
        self.addDataListener()
    }

    func addIndicatorEvent() {
        photosViewModel.indicatorActivity.bind { [weak self] isActive in
            
        }
    }
    
    func fetchPhotosList() {
        photosViewModel.fetchPhotosList()
    }
    
    func addDataListener() {
        
        // Bing Error Message
        photosViewModel.gettingError.bind { messages in
            self.displayAlert(title: messages?.0 ?? "Opps!", message: messages?.1 ?? "Please Try Again...")
        }
        
        // Bing DataSource
        photosViewModel.photosData.bind { _ in
            self.reloadTableDataSource()
        }
     
        // Bing table Delegate
        photosTableTableDelegate.didSelectedRow = { [self] photosDetails, indexPath  in
            
            if isSelectionOn {
                if !selectedPhotosIds.contains(photosDetails?.id ?? "") {
                    selectedPhotosIds.append(photosDetails?.id ?? "")
                } else {
                    selectedPhotosIds.removeAll { $0 == photosDetails?.id ?? "" }
                }
                photosTable.reloadRows(at: [indexPath], with: .automatic)
                isNeedToGiveDeleteOption()
            } else {
                guard let previewVC = self.getViewController(type: PreviewVC.self) else { return }
                previewVC.currentIndex = indexPath.row
                previewVC.photosDetailsArray = photosViewModel.photosData.value ?? []
                self.navigationController?.pushViewController(previewVC, animated: true)
            }
        }
        
        photosCollectionDelegate.didSelectItem = { [self] photosDetails, indexPath  in
            
            if isSelectionOn {
                if !selectedPhotosIds.contains(photosDetails?.id ?? "") {
                    selectedPhotosIds.append(photosDetails?.id ?? "")
                } else {
                    selectedPhotosIds.removeAll { $0 == photosDetails?.id ?? "" }
                }
                photosCollection.reloadItems(at: [indexPath])
                isNeedToGiveDeleteOption()
            } else {
                guard let previewVC = self.getViewController(type: PreviewVC.self) else { return }
                previewVC.currentIndex = indexPath.row
                previewVC.photosDetailsArray = photosViewModel.photosData.value ?? []
                self.navigationController?.pushViewController(previewVC, animated: true)
            }
        }
    }

    
    func reloadTableDataSource() {
        
        photosTableDataSource =  PhotosTableDataSource(cellIdentifier: "ListViewCell", items: photosViewModel.photosData.value, configureCell: { tableCell, photosDetails in
            tableCell.photosDetails = photosDetails
            tableCell.isCellSelected = self.selectedPhotosIds.contains(photosDetails.id)
            
        })
        
        DispatchQueue.main.async { [self] in
            photosTable.dataSource = photosTableDataSource
            photosTable.reloadData()
        }
    }
    
    func reloadCollectionDataSource() {
        
        photosCollectionDataSource =  PhotosCollectionDataSource(cellIdentifier: "GridViewCell", items: photosViewModel.photosData.value, configureCell: { collectionCell, photosDetails in
            collectionCell.photosDetails = photosDetails
            collectionCell.isCellSelected = self.selectedPhotosIds.contains(photosDetails.id)
            
        })
        
        DispatchQueue.main.async { [self] in
            photosCollection.dataSource = photosCollectionDataSource
            photosCollection.reloadData()
        }
    }
    
    func isNeedToGiveDeleteOption() {
        btnRemove.isHidden = !(selectedPhotosIds.count > 0)
    }
    
    // MARK: - Button Event
    @IBAction func btnGridListTapped(_ sender: UIButton) {
        isGridOn = !isGridOn
        let imgname = isGridOn ? "listImg" : "GridImg"
        let image = UIImage(named: imgname) ?? UIImage()
        btnGridList.setImage(image, for: .normal)
        if isGridOn {
            photosTable.isHidden = true
            photosCollection.isHidden = false
            reloadCollectionDataSource()
        } else {
            photosTable.isHidden = false
            photosCollection.isHidden = true
            reloadTableDataSource()
        }
       
    }
    
    @IBAction func btnRemoveTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSelectUnSelectTapped(_ sender: UIButton) {
        isSelectionOn = !isSelectionOn
        let btnTitle = isSelectionOn ? "UnSelect" : "Select"
        btnSelectUnSelect.setTitle(btnTitle, for: .normal)
    }
    
}

// MARK: - Button Event
extension PhotosVC {
    
}
