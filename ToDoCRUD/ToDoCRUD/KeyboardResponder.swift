//
//  KeyboardResponder.swift
//  ToDoCRUD
//
//  Created by Илья on 04.02.2024.
//

import SwiftUI
import Combine

//class KeyboardResponder: ObservableObject {
//    private var cancellables: Set<AnyCancellable> = []
//    
//    @Published var keyboardHeight: CGFloat = 0
//    
//    init() {
//        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
//            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
//            .map { $0.height }
//            .assign(to: \.keyboardHeight, on: self)
//            .store(in: &cancellables)
//        
//        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
//            .map { _ in CGFloat.zero }
//            .assign(to: \.keyboardHeight, on: self)
//            .store(in: &cancellables)
//    }
//}
