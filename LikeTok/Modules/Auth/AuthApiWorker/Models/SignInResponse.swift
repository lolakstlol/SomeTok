// MARK: - SignInResponse
struct SignInResponse: Codable {
    let data: SignInDataClass
    let result: SignInResult
}

// MARK: - DataClass
struct SignInDataClass: Codable {
    let token, uuid: String
}

// MARK: - Result
struct SignInResult: Codable {
    let message: String
    let status: Bool
}
