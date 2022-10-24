# CrackStationWrapper

A test harness for the `CrackStation` assignment in CS 561.  This test harness is for POC v1 only, so single-character passwords encrypted using SHA-1.  We plan to expand it to POC v2 and MVP.

## Usage

Under `dependencies` in the `Package.swift` file, add the git URL of the concrete implementation to test:
<img width=700 src="https://user-images.githubusercontent.com/4765449/197596815-51b5b240-e087-4fbd-bf96-66b94f08b3fa.png">

### If you are a student

So, if you are a student trying to run this test harness on your own code, then uncomment the line above and replace `<YOUR GITHUB USERNAME>` with... your github username.  If the link to your repo is different, then replace the entire URL.

### If you are a TA

If the student repository is private (as it should be for this assignment), then make sure the student adds you as a *collaborator*.  Then, use the ssh git link for the git URL.  For the version tag to work, the student must `git tag` their release using *semantic versioning* (e.g. `git tag 1.0.0`).


## Handy tricks

### From the terminal (e.g. if you don't have Xcode)

Resetting your package cache:
`swift package reset`
This should force your packages to re-fetch.  (Well, technically, force your package's _dependencies_ to re-fetch; but in this case your package is the dependency of the test harness, so...)

### In Xcode

Resetting your package cache, which should force your package to re-fetch.  (Well, technically, force your package's _dependencies_ to re-fetch; but in this case your package is the dependency of the test harness, so...)

<img width=500 src="https://user-images.githubusercontent.com/4765449/197598041-e8d5cbbb-35c3-49dc-983c-e96f322e0552.png">
