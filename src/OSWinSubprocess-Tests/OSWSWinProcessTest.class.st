Class {
	#name : #OSWSWinProcessTest,
	#superclass : #TestCase,
	#category : #'OSWinSubprocess-Tests'
}

{ #category : #tests }
OSWSWinProcessTest >> testBasicCommand [
	| newprocess |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := OSWSWinProcess new 
		shellCommand: 'echo ok';
		runAndWait.
	self deny: newprocess isRunning.
	self assert: newprocess exitCode equals: 0.
	self assert: newprocess isSuccess

]

{ #category : #tests }
OSWSWinProcessTest >> testBasicCommandWithArguments [
	| newprocess |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := OSWSWinProcess new 
		shellCommand: 'echo'
		arguments: #('ok');
		runAndWait.
	self deny: newprocess isRunning.
	self assert: newprocess exitCode equals: 0.
	self assert: newprocess isSuccess

]

{ #category : #tests }
OSWSWinProcessTest >> testCanDetectIfProcessIsRunning [
	| newprocess |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := OSWSWinProcess new
		shellCommand: 'timeout 1';
		run.
	self assert: newprocess isRunning.
	1 seconds wait.
	self deny: newprocess isRunning.
		
]

{ #category : #tests }
OSWSWinProcessTest >> testCanTerminateProcess [
	| newprocess succeeded |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := OSWSWinProcess new 
		shellCommand: 'timeout 50';
		run.
	self assert: newprocess isRunning.
	succeeded := newprocess terminate.
	self assert: succeeded.
	1 second wait. "let time to the cleanup being executed"
	self deny: newprocess isRunning.
	self deny: newprocess isSuccess.
]

{ #category : #tests }
OSWSWinProcessTest >> testGivenACommandIncludingNonAsciiCharsThenCommandSucceed [
	| newprocess tempDir |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	tempDir := (FileLocator temp / 'Yann-Gaël Bérès') asFileReference.
	self deny: tempDir exists.
	
	[ newprocess := OSWSWinProcess new 
		shellCommand: 'mkdir'
		arguments: {tempDir fullName surroundedByDoubleQuotes};
		runAndWait.
	self assert: newprocess isSuccess.
	self assert: tempDir exists. ]
		ensure: [ tempDir ensureDelete ]
	

]

{ #category : #tests }
OSWSWinProcessTest >> testGivenBasicCommandWhenCommandDoesNotExistThenExitCodeIsNot0 [
	| newprocess |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	newprocess := OSWSWinProcess new 
		shellCommand: 'nonexistingcommand foo bar'.
	self deny: newprocess exitCode equals: 0.
	self deny: newprocess isSuccess
]

{ #category : #tests }
OSWSWinProcessTest >> testProcessTimeOut [
	| newprocess start delta |
	Smalltalk os isWindows ifFalse: [ self skip. ^ self  ].
	
	start := Time now asMilliSeconds.
	newprocess := OSWSWinProcess new 
		shellCommand: 'sleep 50';
		run;
		waitForCompletionTimeout: 3 seconds asMilliSeconds.
	"wait is blocking"
	delta := Time now asMilliSeconds - start.
	self deny: newprocess isRunning.
	self deny: newprocess isSuccess.
	self assert: newprocess hasTimedOut.
	self 
		assert: (delta between: 3 seconds asMilliSeconds and: 4 seconds asMilliSeconds)
		description: 'expected 3 seconds wait, got ', delta asString , ' milliseconds'.
]
