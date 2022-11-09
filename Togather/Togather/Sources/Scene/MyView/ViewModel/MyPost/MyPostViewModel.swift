import Foundation
import Moya
import SwiftUI

class MyPostViewModel: ObservableObject {
    let postClient = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var postList: [Posts] = []
    
    func post() {
        postClient.request(.getMyPosts) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200...206:
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        if let data = try? decoder.decode(MyViewUserPostModel.self, from: result.data) {
                            
                            self.postList = data.post_list.map { index in
                                let postID = index.post_id
                                let title = index.title
                                let users: Users = Users(user_id: index.user.user_id, user_name: index.user.user_name, profile_image_url: index.user.profile_image_url)
                                let createdAt = index.created_at
                                let tags: [Tags] = index.tags.map {
                                    let name = $0.name
                                    let imageURL = $0.image_url
                                    
                                    return Tags(name: name, image_url: imageURL)
                                }
                                let like_count = index.like_count
                                
                                return Posts(
                                    post_id: postID,
                                    title: title,
                                    users: users,
                                    tags: tags,
                                    created_at: createdAt,
                                    like_count: like_count
                                )
                            }
                        } else {
                            print("⚠️post docoder error")
                        }
                    }
                    
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️post error: \(err.localizedDescription)")
            }
        }
    }
}

