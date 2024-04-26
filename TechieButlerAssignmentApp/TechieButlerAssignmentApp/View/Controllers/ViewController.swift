//
//  ViewController.swift
//  TechieButlerAssignmentApp
//
//  Created by Karamjeet Singh on 26/04/24.
//

import UIKit

class ViewController: UIViewController {

// MARK: - Outlets
    @IBOutlet weak var postTblView: UITableView!

// MARK: - Objects & Variable
    let postViewModel = PostViewModel()
    var isLoadingList = false

    // MARK: - ClassConstants
 private let postCellName = "PostCell"

    // MARK: - View life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        setupTableView()
        registerCells()
        fetchPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showPostDetail",
              let indexPath = postTblView.indexPathForSelectedRow,
              let detailViewController = segue.destination as? PostDetailViewController {
               detailViewController.postData = postViewModel.posts[indexPath.row]
           }
       }
}

// MARK: - SetUp UI

extension ViewController {
    func setupTableView() {
        postTblView.dataSource = self
        postTblView.delegate = self
        postTblView.estimatedRowHeight = 60.0
        postTblView.rowHeight = UITableView.automaticDimension
    }
    
    func registerCells() {
        let nib = UINib(nibName: postCellName, bundle: nil)
        postTblView.register(nib, forCellReuseIdentifier: postCellName)
    }
}


// MARK: - Web Services
extension ViewController {
    func fetchPosts() {
        isLoadingList = true
        postViewModel.fetchPosts { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.isLoadingList = false
                    self?.postTblView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableView DataSource and Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellName, for: indexPath) as? PostCell
        
        let post = postViewModel.posts[indexPath.row]
        cell?.lblId.text = "\(post.id)"
        cell?.lblTitle.text = post.title
        
               // Perform heavy computation asynchronously
               DispatchQueue.global().async {
                      let startTime = CFAbsoluteTimeGetCurrent()
                   let factorial = self.postViewModel.HeavyComputationOptimization(number: indexPath.row)
                      let endTime = CFAbsoluteTimeGetCurrent()
                      let timeElapsed = endTime - startTime
                      print("Factorial of \(indexPath.row) is \(factorial). Time taken: \(timeElapsed) seconds")
            }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          performSegue(withIdentifier: "showPostDetail", sender: nil)
      }
}

// MARK: - Scroll view delegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 2 && !isLoadingList {
            // Load more data when the user is near the end of the list
            fetchPosts()
        }
    }
}
