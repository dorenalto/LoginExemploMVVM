//
//  LoginStrings.swift
//  LoginMVVM
//
//  Created by dorenalto mangueira couto on 01/12/24.
//

import Foundation

protocol StringValue {
    var value: String { get }
}

enum AppStrings: String, StringValue {
    // Placeholders
    case usernamePlaceholder = "Usuário"
    case passwordPlaceholder = "Senha"

    // Button Titles
    case loginButton = "Entrar"
    case loadingButton = "Carregando..."

    // Alerts
    case errorTitle = "Erro"
    case errorEmptyFields = "Use seu usuário e senha para acessar."
    case successTitle = "Sucesso"
    case successMessage = "Token: %@"
    
    // Global Strings
    case ok = "OK"

    // Enum compliance
    var value: String { self.rawValue }
}
