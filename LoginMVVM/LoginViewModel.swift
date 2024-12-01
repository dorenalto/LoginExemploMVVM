//
//  LoginViewModel.swift
//  LoginMVVM
//
//  Created by dorenalto mangueira couto on 01/12/24.
//

import Foundation

class LoginViewModel {
    private let loginService: LoginServiceProtocol

    // Bindings para View
    var isLoading: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onSuccess: ((String) -> Void)?

    init(loginService: LoginServiceProtocol = LoginService()) {
        self.loginService = loginService
    }

    func performLogin(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            onError?(AppStrings.errorEmptyFields.value)
            return
        }

        isLoading?(true)
        let credentials = LoginModel(username: username, password: password)

        loginService.login(with: credentials) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                switch result {
                case .success(let token):
                    self?.onSuccess?(token)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
