extension Jargon: Equatable {
    public static func == (lhs: Jargon, rhs: Jargon) -> Bool {
        guard lhs.phrase == rhs.phrase else { return false }

        return true
    }
}
