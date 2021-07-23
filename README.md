# ClearScore iOS test
[ClearScore – iOS technical assessment](ClearScore%20-%20Technical%20Task.docx)

##Implementation

The first thought to face this test has been to separate the project into modules where is possible and where it makes sense (of course I could separate more with more time). Then I created the Network layer in a separated framework handled with SPM.

The second thought was *"I would like to use Combine"* **It's the first time I use Combine!**.

I'm aware that probably is not a good idea to make a tech test using something you are not yet comfortable with, but...

**I LIKE CHALLENGES!**

---

###Network layer

The Network layer has a classic structure, but also has a struct called `Endpoint` to simplify the construction of `URLRequest`.
	I didn't make the network request generic, but it just returns a pure and clean response with `Data` or `Error`, this because I left the mapping concern to the Domain layer.
	
###Architectural pattern

As an architectural pattern I chose **MVVM+C** because is a good option for this kind of project, it allows to have good separation of concerns following the SOLID principles, but at the same time is not extremely fragmented like VIPER that in this case I consider overkill.

The structure contains a **Routing** system for handling the navigation and the **Repository** pattern to handle the network jobs and mapping.

The communication between ViewModel and View is made with reactive paradigm using **Combine** and the update is led with State approach.

All objects' dependencies are handled with **Dependency injection** in order to have a full testable code.

###UI

Where was possible I tried to make separated components for the UI elements.

As you can see in the code I didn't use any storyboard or XIB, this doesn't mean I'm against those, but there are pros and cons, and maybe, if we want to think in advance by using declarative UI with SwiftUI, probably the refactoring will be easiest with programming approach (of course... better if the legacy code has good separation between UI and Business logic).

###Tests

I tried to have good test coverage (of course 100% of coverage doesn't mean the tests are good or vice versa, but it is at least the first sign of code robustness), I wrote tests for almost all the business logic. I left UI untested because I think this is a choice that should be taken considering many factors in the tech team.
The team could consider using native UITest for an E2E or just use Snapshot tests.

## TODO with more time

- NetworkClient test
- Persistance
- User friendly error handling
- Snapshot tests
- Separated module for UI