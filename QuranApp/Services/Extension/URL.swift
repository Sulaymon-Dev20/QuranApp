//
//  URL.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import Foundation

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value?.replacingOccurrences(of: "+", with: " ")
        }
    }
    
    func isWorking() -> Bool {
        var result = false
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: self) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                result = (200...299).contains(httpResponse.statusCode)
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        return result
    }
}
