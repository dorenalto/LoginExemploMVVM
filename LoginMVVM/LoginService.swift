//
//  LoginService.swift
//  LoginMVVM
//
//  Created by dorenalto mangueira couto on 01/12/24.
//

import Foundation

protocol LoginServiceProtocol {
    func login(with credentials: LoginModel, completion: @escaping (Result<String, Error>) -> Void)
}

class LoginService: LoginServiceProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func login(with credentials: LoginModel, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://api.exemplo.com/login") else {
            completion(.failure(NSError(domain: "URL inválida", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let bodyData = try JSONEncoder().encode(credentials)
            request.httpBody = bodyData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let data = data else {
                completion(.failure(NSError(domain: "Erro na resposta", code: 500, userInfo: nil)))
                return
            }
            
            if let token = String(data: data, encoding: .utf8) {
                completion(.success(token))
            } else {
                completion(.failure(NSError(domain: "Token inválido", code: 500, userInfo: nil)))
            }
        }
        
        task.resume()
    }
}
