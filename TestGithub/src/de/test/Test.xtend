package de.test

class Test {
	def static void main(String[] args) {
		println("Hello " + test)
	}
	
	def static test() {
		"World" + new Test2().test("bbb")
	}
}
