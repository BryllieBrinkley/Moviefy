//
//  APIClient.swift
//  Moviefy
//
//  Created by Jibryll Brinkley on 4/28/26.
//  Copyright © 2026 Adriana González Martínez. All rights reserved.
//

// Client: a computer in a network that uses the services provided by a server.
//Server: a piece of computer hardware or software (computer program) that provides functionality for other programs or devices (ie clients)

// API: part of the server that receives requests and sends responses.

// Network Manager / Networking Layer: a well-structured chunk of code used to make API requests and handle its responses from an external server.


import Foundation

struct APIClient {
    static let shared = APIClient()
    let session = URLSession(configuration: .default)
}

