//
//  QueueViewModel.swift
//  BindableExample
//
//  Created by Hiral Naik on 1/6/26.
//

import ios_bindable
import Foundation

final class QueueViewModel {

    // Outputs
    let users = ConcurrentQueueBindable<[User]>([])
    let isLoading = ConcurrentQueueBindable<Bool>(false)
    let errorMessage = ConcurrentQueueBindable<String>(nil)
    let title = ConcurrentQueueBindable<String>("Users")

    func loadUsers() {
        isLoading.value = true
        errorMessage.value = nil

        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1.2) {
            let fetchedUsers = [
                User(id: 1, name: "Queue"),
                User(id: 2, name: "Background"),
                User(id: 3, name: "Concurrent")
            ]

            self.users.value = fetchedUsers
            self.isLoading.value = false
        }
    }

    func numberOfRows() -> Int {
        users.value?.count ?? 0
    }

    func user(at index: Int) -> User? {
        guard let users = users.value, index < users.count else { return nil }
        return users[index]
    }
}
