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
            self.reloadCollectionDataSource()
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
            } else {
                
            }
            print("")
//            guard let employeeDetailsVC = self.getViewController(type: EmployeeDetailsVC.self) else { return }
//            employeeDetailsVC.employeeData = employeeData
//            self.navigationController?.pushViewController(employeeDetailsVC, animated: true)
            
        }
        
        photosCollectionDelegate.didSelectItem = { [self] photosDetails, indexPath  in
            
            if isSelectionOn {
                if !selectedPhotosIds.contains(photosDetails?.id ?? "") {
                    selectedPhotosIds.append(photosDetails?.id ?? "")
                } else {
                    selectedPhotosIds.removeAll { $0 == photosDetails?.id ?? "" }
                }
                photosCollection.reloadItems(at: [indexPath])
            } else {
                guard let previewVC = self.getViewController(type: PreviewVC.self) else { return }
                previewVC.currentIndex = indexPath.row
                previewVC.photosDetailsArray = photosViewModel.photosData.value ?? []
                self.navigationController?.pushViewController(previewVC, animated: true)
            }
            print("")
//            guard let employeeDetailsVC = self.getViewController(type: EmployeeDetailsVC.self) else { return }
//            employeeDetailsVC.employeeData = employeeData
//            self.navigationController?.pushViewController(employeeDetailsVC, animated: true)
            
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
    
    // MARK: - Button Event
    @IBAction func btnGridListTapped(_ sender: UIButton) {
        
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
