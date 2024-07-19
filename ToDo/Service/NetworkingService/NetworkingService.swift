import Foundation
protocol NetworkingServiceManager {

}

final class NetworkingService {
    let request = ManagerRequest()
    var revision = 0
    var isDirty = false
    var model = [TodoItem]()

    func decodeData(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        let result = try decoder.decode(Response.self, from: data)
        return result
    }

    func getData() {
        let request = try! request.requestGET()
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            if let error = error {
                self.isDirty = true
                return
            }

            guard let data = data else {
                self.isDirty = true
                return
            }

            do {
                self.isDirty = false
                let result = try decodeData(data)
                self.model = result.list
                self.revision = result.revision
            } catch {
            }
        }
        task.resume()
        }

    func postData(item: TodoItem) {
        let request = (try! request.requestPOST(revision: String(revision), item: item))!

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                self.isDirty = true
                return
            }

            guard let data = data else {
                self.isDirty = true
                return
            }

            do {
                self.isDirty = false
                let result = try self.decodeData(data)
                self.model = result.list
                self.revision = result.revision
            } catch {
            }
        }
        task.resume()

        }
    }
