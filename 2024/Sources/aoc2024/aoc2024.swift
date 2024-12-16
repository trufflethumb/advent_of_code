func p(_ string: @autoclosure () -> String) {
    if T.shouldPrint {
        print(string())
    }
}

actor T {
    static var shouldPrint = false

    static func p() {
        Self.shouldPrint = true
    }
}
