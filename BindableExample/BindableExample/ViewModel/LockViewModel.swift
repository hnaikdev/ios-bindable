//
//  ProfileViewModel.swift
//  BindableExample
//
//  Created by Hiral Naik on 1/6/26.
//

import ios_bindable
import Foundation

final class LoginViewModel {

    let username = ConcurrentLockBindable<String>("")
    let password = ConcurrentLockBindable<String>("")

    let isLoading = ConcurrentLockBindable<Bool>(false)
    let errorMessage = ConcurrentLockBindable<String>(nil)
    let isLoginEnabled = ConcurrentLockBindable<Bool>(false)

    init() {
        username.bind { [weak self] _ in
            self?.validate()
        }
        password.bind { [weak self] _ in
            self?.validate()
        }
    }

    private func validate() {
        let isValid =
            !(username.value?.isEmpty ?? true) &&
            !(password.value?.isEmpty ?? true)
        isLoginEnabled.value = isValid
    }

    func login() {
        guard isLoginEnabled.value == true else { return }

        isLoading.value = true
        errorMessage.value = nil

        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            if self.username.value == "admin" && self.password.value == "1234" {
                self.isLoading.value = false
            } else {
                self.isLoading.value = false
                self.errorMessage.value = "Invalid credentials"
            }
        }
    }
}
