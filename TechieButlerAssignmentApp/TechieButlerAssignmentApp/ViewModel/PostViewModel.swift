//
//  PostViewModel.swift
//  TechieButlerAssignmentApp
//
//  Created by Karamjeet Singh on 26/04/24.
// "\(APIs.baseUrl)\(APIs.post)_page=\(currentPage)&_limit=\(pageSize)"

import Foundation

import Foundation

class PostViewModel {
    var posts = [PostModel]()
    var currentPage = 1
    let pageSize = 20

    func fetchPosts(completion: @escaping (Bool) -> Void) {
        let url = URL(string: "\(APIs.baseUrl)\(APIs.post)?_page=\(currentPage)&_limit=\(pageSize)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(false)
                return
            }
            do {
                let fetchedPosts = try JSONDecoder().decode([PostModel].self, from: data)
                self.posts.append(contentsOf: fetchedPosts)
                self.currentPage += 1
                completion(true)
            } catch {
                completion(false)
            }
        }.resume()
    }
    
    func HeavyComputationOptimization(number: Int) -> Int {
           var result = 1
           for i in 0...number {
               result *= i
           }
           return result
       }
}
