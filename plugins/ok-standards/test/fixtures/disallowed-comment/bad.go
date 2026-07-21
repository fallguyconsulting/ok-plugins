package disallowed

// This is a prose comment with no exemption — should be a violation.
func Foo() int {
	return 1
}
