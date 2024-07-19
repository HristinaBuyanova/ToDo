import Foundation

final class ManagerRequest {

    let urlHive = UrlToren.url.rawValue
    let valueToken = UrlToren.token.rawValue

//    let path = "/todo"
//    let host = "beta.mrdekk.ru"
//
//    private func createURL() -> URL? {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = host
//        components.path = path
//        return components.url
//    }

    func requestGET() throws -> URLRequest? {
        guard let url = URL(string: urlHive) else {
        print("Неверный формат ссылки")
            throw NSError()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(valueToken, forHTTPHeaderField: "Authorization")
        return request
    }

    func requestPATCH(revision: String) throws -> URLRequest? {
        guard let url = URL(string: urlHive) else {
        print("Неверный формат ссылки")
            throw NSError()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(valueToken, forHTTPHeaderField: "Authorization")
        request.setValue(revision, forHTTPHeaderField: "X-Last-Known-Revision")
        return request
    }

    func requestIdGET(id: String) throws -> URLRequest? {
        guard let url = URL(string: urlHive + "/" + id) else {
        print("Неверный формат ссылки")
            throw NSError()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(valueToken, forHTTPHeaderField: "Authorization")
        return request
    }

    func requestPOST(revision: String) throws -> URLRequest? {
        guard let url = URL(string: urlHive) else {
        print("Неверный формат ссылки")
            throw NSError()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(valueToken, forHTTPHeaderField: "Authorization")
        request.setValue(revision, forHTTPHeaderField: "X-Last-Known-Revision")
        return request
    }

    func requestPUT(revision: String, id: String) throws -> URLRequest? {
        guard let url = URL(string: urlHive + "/" + id) else {
        print("Неверный формат ссылки")
            throw NSError()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue(valueToken, forHTTPHeaderField: "Authorization")
        request.setValue(revision, forHTTPHeaderField: "X-Last-Known-Revision")
        return request
    }

    func requestDELETE(revision: String, id: String) throws -> URLRequest? {
        guard let url = URL(string: urlHive + "/" + id) else {
        print("Неверный формат ссылки")
            throw NSError()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(valueToken, forHTTPHeaderField: "Authorization")
        request.setValue(revision, forHTTPHeaderField: "X-Last-Known-Revision")
        return request
    }
}
