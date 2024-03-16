//
//  ViewController.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import UIKit

class PhotosVC: UIViewController {

    @IBOutlet weak var photosTable: UITableView!
    
    lazy var photosViewModel: PhotosViewModel = {
       return PhotosViewModel()
    }()
    
    private var photosTableDataSource: PhotosTableDataSource<ListViewCell, PhotosDetails>?
    private var photosTableTableDelegate = PhotosTableTableDelegate<PhotosDetails>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosTable.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
        photosTable.delegate = photosTableTableDelegate
        
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
            self.reloadDataSource()
        }
     
        // Bing Delegate
        photosTableTableDelegate.didSelectedRow = { photosDetails in
            
            print("")
//            guard let employeeDetailsVC = self.getViewController(type: EmployeeDetailsVC.self) else { return }
//            employeeDetailsVC.employeeData = employeeData
//            self.navigationController?.pushViewController(employeeDetailsVC, animated: true)
        }
    }
    
    func reloadDataSource() {
        
        photosTableDataSource =  PhotosTableDataSource(cellIdentifier: "ListViewCell", items: photosViewModel.photosData.value, configureCell: { tableCell, photosDetails in
            tableCell.photosDetails = photosDetails
        })
        
        DispatchQueue.main.async { [self] in
            photosTable.dataSource = photosTableDataSource
            photosTable.reloadData()
        }
    }

}

//extension PhotosVC: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as? ListViewCell else { return UITableViewCell() }
//        
//        return tableCell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.height - 50
//    }
//    
//    
//}

