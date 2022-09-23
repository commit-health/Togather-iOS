import Foundation
import Moya

class ChangeMyInfoViewModel: ObservableObject {
    let userClient = MoyaProvider<UserService>(plugins: [MoyaLoggerPlugin()])
    
    @Published var name: String = ""
    @Published var profileImageLink: String = ""
    @Published var showingAlert: Bool = false
    
    func signUpClient() {
        userClient.request(.changeMyInfo(name: name, picture: profileImageLink)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 204:
                    self.showingAlert = true
                default:
                    print(result.statusCode)
                }
            case .failure(let err):
                print("⛔️changeMyInfo Error: \(err.localizedDescription)")
            }
        }
    }
}
