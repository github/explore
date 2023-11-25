---
aliases: test-driven-development
created_by: Kent Beck, D.D. McCracken
display_name: Test-driven development
released: 1957
short_description: Test-driven development is a development process with a test-first approach relying on requirements being converted to test cases.
topic: tdd
wikipedia_url: https://en.wikipedia.org/wiki/Test-driven_development
related: atdd, bdd, testing, extreme-programming, continuous-testing
---
**Test-driven development** (**TDD**) is a software development process relying on software requirements being converted to test cases before software is fully developed, and tracking all software development by repeatedly testing the software against all test cases. This is as opposed to software being developed first and test cases created later. Programmers also apply the concept to improving and debugging legacy code developed with older techniques.

# Process
1. Add a test
2. Run all tests. The new test should fail for expected reasons
3. Write the simplest code that passes the new test
4. All tests should now pass
5. Refactor as needed, using tests after each refactor to ensure that functionality is preserved

Repeat.
