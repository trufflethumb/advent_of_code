// comment out line 3 to disable printing for debugging
// in the future, learn how to use os.log
func p(_ string: @autoclosure () -> String) {
    print(string())
}

