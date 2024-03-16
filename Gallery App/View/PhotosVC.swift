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
    @IBOutlet weak var lblSelectCount: UILabel!
    
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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        photosTable.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
        photosTable.delegate = photosTableTableDelegate
        
        photosCollection.register(UINib(nibName: "GridViewCell", bundle: nil), forCellWithReuseIdentifier: "GridViewCell")
        photosCollection.delegate = photosCollectionDelegate
        
        self.fetchPhotosList()
        self.addDataListener()
        self.bindDelegates()
    }
    
    
    // MARK: - Other Methods
    
    func fetchPhotosList() {
        photosViewModel.fetchPhotosList()
    }
    
    func isNeedToGiveDeleteOption() {
        btnRemove.isHidden = !(selectedPhotosIds.count > 0)
    }
    
    func refreshCount() {
        lblSelectCount.text = selectedPhotosIds.count > 0 ? "(\(selectedPhotosIds.count))" : ""
    }
    
    func addDataListener() {
        
        // Bing Error Message
        photosViewModel.gettingError.bind { messages in
            self.displayAlert(title: messages?.0 ?? "Opps!", message: messages?.1 ?? "Please Try Again...")
        }
        
        // Bing Data Listener
        photosViewModel.photosData.bind { _ in
            self.reloadTableDataSource()
            self.reloadCollectionDataSource()
        }
     
        
    }
    
    // MARK: - Delegats Methods
    
    func bindDelegates() {
        // Bind table Delegate
        photosTableTableDelegate.didSelectedRow = { [self] photosDetails, indexPath  in
            
            if isSelectionOn {
                if !selectedPhotosIds.contains(photosDetails?.id ?? "") {
                    selectedPhotosIds.append(photosDetails?.id ?? "")
                } else {
                    selectedPhotosIds.removeAll { $0 == photosDetails?.id ?? "" }
                }
                photosTable.reloadRows(at: [indexPath], with: .automatic)
                isNeedToGiveDeleteOption()
                refreshCount()
            } else {
                guard let previewVC = self.getViewController(type: PreviewVC.self) else { return }
                previewVC.currentIndex = indexPath.row
                previewVC.photosDetailsArray = photosViewModel.photosData.value ?? []
                self.navigationController?.pushViewController(previewVC, animated: true)
            }
        }
        
        // Bind collection Delegate
        photosCollectionDelegate.didSelectItem = { [self] photosDetails, indexPath  in
            
            if isSelectionOn {
                if !selectedPhotosIds.contains(photosDetails?.id ?? "") {
                    selectedPhotosIds.append(photosDetails?.id ?? "")
                } else {
                    selectedPhotosIds.removeAll { $0 == photosDetails?.id ?? "" }
                }
                photosCollection.reloadItems(at: [indexPath])
                refreshCount()
                isNeedToGiveDeleteOption()
            } else {
                guard let previewVC = self.getViewController(type: PreviewVC.self) else { return }
                previewVC.currentIndex = indexPath.row
                previewVC.photosDetailsArray = photosViewModel.photosData.value ?? []
                self.navigationController?.pushViewController(previewVC, animated: true)
            }
        }
    }

    // MARK: - DataSource Methods
    
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
        isGridOn = !isGridOn
        let imgname = isGridOn ? "listImg" : "GridImg"
        let image = UIImage(named: imgname) ?? UIImage()
        btnGridList.setImage(image, for: .normal)
        photosTableTableDelegate.animatedCell.removeAll()
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
        let alertController = UIAlertController(title: "Are You sure!", message: "You want to delete.", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [self] action in
            photosTableTableDelegate.animatedCell.removeAll()
            photosViewModel.removePhotosDetails(ids: selectedPhotosIds)
            selectedPhotosIds.removeAll()
            isNeedToGiveDeleteOption()
            refreshCount()
            btnSelectUnSelectTapped(UIButton())
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in }))

        present(alertController, animated: true, completion: nil)
             
    }
    
    @IBAction func btnSelectUnSelectTapped(_ sender: UIButton) {
        isSelectionOn = !isSelectionOn
        let btnTitle = isSelectionOn ? "Cancel" : "Select"
        btnSelectUnSelect.setTitle(btnTitle, for: .normal)
        if !isSelectionOn {
            var indexPaths: [IndexPath] = []
            for id in selectedPhotosIds {
                if let firstIndex = photosViewModel.photosData.value?.firstIndex(where: { $0.id == id }) {
                    if isGridOn {
                        indexPaths.append( IndexPath(row: firstIndex, section: 0))
                    } else {
                        indexPaths.append(IndexPath(item: firstIndex, section: 0))
                    }
                }
            }
            selectedPhotosIds.removeAll()
            if isGridOn {
                photosCollection.reloadItems(at: indexPaths)
            } else {
                photosTable.reloadRows(at: indexPaths, with: .automatic)
            }
            isNeedToGiveDeleteOption()
            refreshCount()
        }
    }
    
}

