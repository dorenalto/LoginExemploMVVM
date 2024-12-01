# LoginExemplo

**LoginExemplo** é um exemplo de aplicativo iOS que implementa um sistema de login seguindo o padrão arquitetural **MVVM** (Model-View-ViewModel). A aplicação foi projetada com foco em boas práticas, como centralização de strings, segurança contra hardcoded, injeção de dependências e fácil manutenção.

## Estrutura do Projeto
O projeto segue a arquitetura MVVM:

- **Model**:
  - Representa os dados e lógica de negócio.
  - Exemplo: `LoginModel` (estrutura para encapsular os dados de login).

- **ViewModel**:
  - Gerencia a lógica de apresentação e manipula os dados exibidos na View.
  - Exemplo: `LoginViewModel` (lógica para realizar login e gerenciar estados como carregando, sucesso ou erro).

- **View**:
  - Interface do usuário e interação com o usuário.
  - Exemplo: `LoginViewController` (exibe campos de login e mensagens de feedback).

- **Service**:
  - Gerencia as chamadas de API para o backend.
  - Exemplo: `LoginService` (realiza a requisição de login com credenciais).

- **Strings Centralizadas**:
  - Todas as strings usadas no aplicativo estão centralizadas no `enum AppStrings`.
  - Protocolo `StringValue` para acesso seguro usando `.value`.

## Funcionalidades
- **Autenticação de usuário**:
  - Permite o login com nome de usuário e senha.
  - Valida campos obrigatórios.
- **Separação de responsabilidades**:
  - Utilização de MVVM para manter o código modular e organizado.
- **Chamadas de API seguras**:
  - Integração com `URLSession` para comunicação com o backend.
- **Strings centralizadas**:
  - Todas as mensagens e rótulos são configurados no enum `AppStrings`.

## Pré-requisitos
- macOS com Xcode instalado (versão 14.0 ou superior).
- Swift 5.7 ou superior.
- Conexão com uma API REST para autenticação (exemplo: `https://api.exemplo.com/login`).

## Como Configurar e Executar
1. Clone o repositório:
   ```bash
   git clone https://github.com/SEU_USUARIO/LoginExemplo.git
   ```
2. Abra o arquivo `LoginExemplo.xcodeproj` no Xcode.
3. Configure o backend no arquivo `LoginService.swift`, substituindo a URL base da API:
   ```swift
   guard let url = URL(string: "https://api.exemplo.com/login") else {
   ```
4. Execute o aplicativo em um simulador ou dispositivo real clicando em **Run** (`Cmd + R`).

## Estrutura de Código

### Model
Arquivo: `LoginModel.swift`
```swift
struct LoginModel: Codable {
    let username: String
    let password: String
}
```

### Service
Arquivo: `LoginService.swift`
```swift
protocol LoginServiceProtocol {
    func login(with credentials: LoginModel, completion: @escaping (Result<String, Error>) -> Void)
}

class LoginService: LoginServiceProtocol {
    // Implementação de chamada à API
}
```

### ViewModel
Arquivo: `LoginViewModel.swift`
```swift
class LoginViewModel {
    var isLoading: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onSuccess: ((String) -> Void)?

    func performLogin(username: String, password: String) {
        // Lógica de login
    }
}
```

### View
Arquivo: `LoginViewController.swift`
```swift
class LoginViewController: UIViewController {
    private let usernameField: UITextField
    private let passwordField: UITextField
    private let loginButton: UIButton

    override func viewDidLoad() {
        // Configuração da interface e binding com o ViewModel
    }
}
```

### Strings Centralizadas
Arquivo: `AppStrings.swift`
```swift
enum AppStrings: String, StringValue {
    case usernamePlaceholder = "Usuário"
    case passwordPlaceholder = "Senha"
    case loginButton = "Entrar"
    case loadingButton = "Carregando..."
    case errorTitle = "Erro"
    case successTitle = "Sucesso"
    case successMessage = "Token: %@"
}
```

## Extensões Futuras
- Integração com persistência de dados (ex.: Keychain ou UserDefaults).
- Implementação de testes unitários para ViewModel e Service.
- Localização para suporte a múltiplos idiomas.

## Licença
Este projeto está licenciado sob a licença MIT. Consulte o arquivo `LICENSE` para mais informações.

## Contato
- **Autor:** Dorenalto M Couto
- **E-mail:** dorenalto@gmail.com
- **LinkedIn:** [Dorenalto](https://linkedin.com/in/dorenalto)
