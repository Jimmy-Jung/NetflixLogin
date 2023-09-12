# NetflixLogin
SeSAC 9월13일(화) 과제

<img width="300" alt="image" src="https://github.com/Jimmy-Jung/NetflixLogin/assets/115251866/b164a6c2-ce36-41e8-a9a8-f4db56948125">

# Observable

`Observable`은 값의 변경을 감시하는 간단한 방법을 제공하는 Swift 클래스입니다. 값이 변경되면 등록된 클로저 중 어떤 것이든 새로운 값으로 호출됩니다.

```swift
final class Observable<T> {
    private var listener: ((T) -> Void)?
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (_ value: T) -> Void) {
        listener = closure
    }
}

```

## 사용법

`Observable`을 사용하려면 초기 값으로 클래스 인스턴스를 만듭니다.

```swift
let observable = Observable<String>("Hello, world!")

```

그런 다음 값이 변경될 때 호출될 클로저를 등록합니다.

```swift
observable.bind { newValue in
    print("The new value is: \(newValue)")
}

```

Observable의 값이 변경되면 등록된 클로저가 새 값으로 호출됩니다.

```swift
observable.value = "Goodbye, world!"
// 출력: "The new value is: Goodbye, world!"

```

## 예시

다음 코드는 로그인 화면에서 `Observable`을 사용하는 방법을 보여줍니다.

```swift
final class LoginViewModel: LoginViewModelProtocol {
    var email = Observable<String>("")
    var password = Observable<String>("")
    var emailValid = Observable<Bool>(false)
    var passwordValid = Observable<Bool>(false)

    init() {
        self.binding()
    }

    func binding() {
        email.bind { [unowned self] value in
            self.emailValid.value = value.isValidEmail()
            self.checkBothValid()
        }
        password.bind { [unowned self] value in
            self.passwordValid.value = value.isValidPassword()
            self.checkBothValid()
        }
    }

    func checkBothValid() -> Bool {
        return emailValid.value && passwordValid.value {
        }
    }
}

final class LoginViewController: UIViewController {
    var loginView: LoginView!
    var loginViewModel: LoginViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView = LoginView()
        loginViewModel = LoginViewModel()
        configureUI()
        setupAddTarget()
        binding()
    }

    private func binding() {
        loginViewModel.emailValid.bind { [unowned self] value in
            loginView.emailInfoLabel.textColor = value ? .systemGreen : .secondaryLabel
            loginView.loginButton.isEnabled(loginViewModel.checkBothValid())
        }
        loginViewModel.passwordValid.bind { [unowned self] value in
            loginView.passwordInfoLabel.textColor = value ? .systemGreen : .secondaryLabel
            loginView.loginButton.isEnabled(loginViewModel.checkBothValid())
        }
    }
}

```

이 예제에서 `Observable`을 사용하여 로그인 화면의 이메일 및 비밀번호 필드의 변경 사항을 감시합니다. 사용자가 유효한 이메일 주소와 비밀번호를 입력하면 로그인 버튼이 활성화됩니다.

## 결론

`Observable`은 Swift에서 값의 변경을 감시하는 간단하고 효과적인 방법을 제공합니다. 반응형 프로그래밍 또는 데이터 바인딩을 필요로하는 모든 프로젝트에 유용한 도구입니다.
