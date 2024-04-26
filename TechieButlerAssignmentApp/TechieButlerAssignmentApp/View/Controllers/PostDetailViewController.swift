//
//  PostDetailViewController.swift
//  TechieButlerAssignmentApp
//
//  Created by Karamjeet Singh on 26/04/24.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var postDetailTblView: UITableView!
    
    // MARK: - ClassConstants
    private let postCellName = "PostCell"
    
    // MARK: - Objects & Variables
    var postData : PostModel? = nil
    
    // MARK: - View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        registerCells()
    }
}

// MARK: - SetUp UI

extension PostDetailViewController {
    func setupTableView() {
        postDetailTblView.dataSource = self
        postDetailTblView.delegate = self
        postDetailTblView.estimatedRowHeight = 60.0
        postDetailTblView.rowHeight = UITableView.automaticDimension
    }
    
    func registerCells() {
        let nib = UINib(nibName: postCellName, bundle: nil)
        postDetailTblView.register(nib, forCellReuseIdentifier: postCellName)
    }
}

// MARK: - UITableView DataSource and Delegate
extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellName, for: indexPath) as? PostCell

        switch indexPath.row {
        case 0:
            cell?.lblId.text = "User Id:"
            cell?.lblTitle.text = "\(postData?.userID ?? 00)"
        case 1:
            cell?.lblId.text = "Post Id:"
            cell?.lblTitle.text = "\(postData?.id ?? 00)"
        case 2:
            cell?.lblId.text = "Title:"
            cell?.lblTitle.text = postData?.title
        default:
            cell?.lblId.text = "Body:"
            cell?.lblTitle.text = postData?.body
        }
        
        return cell!
    }
}

