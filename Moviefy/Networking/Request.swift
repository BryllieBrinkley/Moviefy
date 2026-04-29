//
//  Request.swift
//  Moviefy
//
//  Created by Jibryll Brinkley on 4/29/26.
//  Copyright © 2026 Adriana González Martínez. All rights reserved.
//

struct APIRequest {
    static let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(Secrets.apiKey)"
        
    ]
}
