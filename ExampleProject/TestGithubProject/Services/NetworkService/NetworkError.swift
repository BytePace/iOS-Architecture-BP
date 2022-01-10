//
//  NetworkError.swift
//  TestGithubProject
enum NetworkError: Error {
    case errorWithMessage(_ message: String)
    case authFailed
    case noInternet
}
