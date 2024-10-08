"
I reprensent a Windows process.
You can instantiate me and configure me to run a child process of Pharo. You can wait for my completion or run me in an asynchronuous way (default).
I use a FFI library PhLWinProcessLibrary to make system calls to the Windows API.
I do not manage standard and error outputs.

WARNING: waiting a process will freeze your image while the process is running.

You can use me as following:
	OSWSWinProcess new 
		command: 'C:\Windows\notepad.exe';
		runAndWait.
		
	OSWSWinProcess new 
		shellCommand: 'echo ok';
		run.
"
Class {
	#name : 'OSWSWinProcess',
	#superclass : 'Object',
	#instVars : [
		'exitCode',
		'isRunning',
		'startupInfo',
		'processInfo',
		'lastErrorCode',
		'command',
		'arguments',
		'surroundArgumentsWithDoubleQuotes',
		'workingDirectory',
		'creationFlags'
	],
	#pools : [
		'OSWSWinTypes'
	],
	#category : 'OSWinSubprocess',
	#package : 'OSWinSubprocess'
}

{ #category : 'constants' }
OSWSWinProcess class >> CREATE_NO_WINDOW [
	"The process is a console application that is being run without a console window. Therefore, the console handle for the application is not set.
This flag is ignored if the application is not a console application, or if it is used with either CREATE_NEW_CONSOLE or DETACHED_PROCESS.

More information: https://docs.microsoft.com/fr-fr/windows/win32/procthread/process-creation-flags"

	^ 16r08000000
]

{ #category : 'constants' }
OSWSWinProcess class >> DETACHED_PROCESS [
	"For console processes, the new process does not inherit its parent's console (the default). The new process can call the AllocConsole function at a later time to create a console. For more information, see Creation of a Console.
This value cannot be used with CREATE_NEW_CONSOLE.

More information: https://docs.microsoft.com/fr-fr/windows/win32/procthread/process-creation-flags"

	^ 16r00000008
]

{ #category : 'private' }
OSWSWinProcess class >> TIMEOUT_INFINITE [
	^ 16rffffffff
]

{ #category : 'constants' }
OSWSWinProcess class >> WAIT_FAILED [
	"From https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject
	The function has failed. To get extended error information, call GetLastError."
	^ 16rFFFFFFFF

]

{ #category : 'constants' }
OSWSWinProcess class >> WAIT_OBJECT_0 [
	"From https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject
	The state of the specified object is signaled."
	^ 0
]

{ #category : 'constants' }
OSWSWinProcess class >> WAIT_TIMEOUT [
	"From https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject
	The time-out interval elapsed, and the object's state is nonsignaled."
	^ 16r00000102
]

{ #category : 'configuring' }
OSWSWinProcess >> arguments [
	^ arguments ifNil: [ arguments := #() ]
]

{ #category : 'configuring' }
OSWSWinProcess >> arguments: aListOfArguments [
	arguments := aListOfArguments asArray.
]

{ #category : 'accessing' }
OSWSWinProcess >> argumentsString [
	| args |
	args := Character space join: 
		(surroundArgumentsWithDoubleQuotes
			ifTrue: [ self arguments collect: #surroundedByDoubleQuotes ]
			ifFalse: [ self arguments ]).

	"cmd.exe /C waits a unique argument. Wrap the whole command but /C to run with double quotes"
	^ (command = self shellCommandPath)
		ifTrue: [ '/C ', args surroundedByDoubleQuotes ]
		ifFalse: [ args ]
]

{ #category : 'running' }
OSWSWinProcess >> basicRun [
	| creationSucceeded |
	startupInfo := OSWSStartupInfoW externalNew.
	startupInfo cb: startupInfo class structureSize.
	processInfo := OSWSProcessInformation externalNew.
	
	creationSucceeded := self ffiLibrary
		createProcess: (Win32WideString fromString: command) getHandle
		command: (Win32WideString fromString: self argumentsString) getHandle
		processAttributes: ExternalAddress null
		threadAttributes: ExternalAddress null
		inheritHandles: false
		creationFlags: creationFlags
		environment: ExternalAddress null
		directory: self workingDirectoryHandle
		startup: startupInfo
		processInformation: processInfo.
		
	creationSucceeded
		ifFalse: [ self setLastErrorCode. OSWSProcessCreationFailed signal: lastErrorCode ].
	isRunning := true.
]

{ #category : 'private' }
OSWSWinProcess >> clean [
	processInfo getHandle
		ifNotNil: 
			[ self closeHandle: processInfo hProcess.
			self closeHandle: processInfo hThread ].
	processInfo free.
	startupInfo free
]

{ #category : 'private' }
OSWSWinProcess >> closeHandle: handle [
	^ self ffiLibrary closeHandle: handle
]

{ #category : 'configuring' }
OSWSWinProcess >> command: appName [
	"The name of the module to be executed. This module can be a Windows-based application. It can be some other type of module (for example, MS-DOS or OS/2) if the appropriate subsystem is available on the local computer.

The string can specify the full path and file name of the module to execute or it can specify a partial name. In the case of a partial name, the function uses the current drive and current directory to complete the specification. The function will not use the search path. This parameter must include the file name extension; no default extension is assumed."
	command := appName
]

{ #category : 'private' }
OSWSWinProcess >> completionCallback [
	self setExitCode.
	self clean
]

{ #category : 'configuring' }
OSWSWinProcess >> creationFlags: anInteger [
	creationFlags := anInteger
]

{ #category : 'accessing' }
OSWSWinProcess >> exitCode [
	^ exitCode 
]

{ #category : 'private' }
OSWSWinProcess >> ffiLibrary [
	^ OSWSWinProcessLibrary uniqueInstance
]

{ #category : 'testing' }
OSWSWinProcess >> hasTimedOut [
	^ self isRunning not 
		and: [ lastErrorCode isNil 
		and: [ exitCode isNil ] ]
]

{ #category : 'initialization' }
OSWSWinProcess >> initialize [
	isRunning := false.
	surroundArgumentsWithDoubleQuotes := false.
	creationFlags := 0.
]

{ #category : 'testing' }
OSWSWinProcess >> isComplete [
	^ isRunning not and: [exitCode notNil]
]

{ #category : 'testing' }
OSWSWinProcess >> isRunning [
	"see https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-waitforsingleobject for more information"
	| returnValue |
	
	(processInfo isNil 
	or: [ processInfo getHandle isNil 
	or: [ processInfo hProcess getHandle isNil ] ])
		ifTrue: [ ^ false ].
	
	returnValue := self ffiLibrary
		waitForSingleObject: processInfo hProcess
		milliSeconds: 0.
	^ returnValue = self class WAIT_TIMEOUT
]

{ #category : 'testing' }
OSWSWinProcess >> isSuccess [
	^ self isRunning not 
		and: [ lastErrorCode isNil 
		and: [ self exitCode = 0 ] ]
]

{ #category : 'public' }
OSWSWinProcess >> lastError [
	^ self ffiLibrary getLastError
]

{ #category : 'running' }
OSWSWinProcess >> run [
	self basicRun.
	self watch.
]

{ #category : 'running' }
OSWSWinProcess >> runAndWait [
	" This methods runs the subprocess AND waits until the child has exited. "
	
	self basicRun.
	self waitForCompletion.
]

{ #category : 'running' }
OSWSWinProcess >> runAndWaitTimeOut: nbMilliSeconds [
	" This methods runs the subprocess AND waits until the child has exited. "
	
	self basicRun.
	self waitForCompletionTimeout: nbMilliSeconds.
]

{ #category : 'running' }
OSWSWinProcess >> runUnwatch [ 
	"Used to run a process and forget about it"
	[ self basicRun ]
	ensure: [ self clean ]
]

{ #category : 'private' }
OSWSWinProcess >> setExitCode [
	| exitCodeValueHolder succeeded |
	
	exitCode ifNotNil: [ ^ self ]. "already set"
	processInfo getHandle ifNil: [ ^ self ]. "process already cleaned. No way to get the exit code"
	
	exitCodeValueHolder := LPDWORD new.
	succeeded := self ffiLibrary
		getProcess: processInfo hProcess
		exitCode: exitCodeValueHolder.
	succeeded ifFalse: [ Warning new messageText: 'Cannot get exit code of the process'; signal ].
	exitCode := exitCodeValueHolder value
]

{ #category : 'private' }
OSWSWinProcess >> setLastErrorCode [
	^ lastErrorCode := self lastError
]

{ #category : 'configuring' }
OSWSWinProcess >> shellCommand [
	command := self shellCommandPath
]

{ #category : 'configuring' }
OSWSWinProcess >> shellCommand: aShellCommandString [
	"This is a simple facility method for the cases when the user wants to use shell as the program.
	This way, the user can directly send shellCommand: 'ECHO y| DEL *.txt' with the whole string 
	rather than having to do set the command cmd.exe, send the '/C' argument, etc etc etc."
	self shellCommand.
	arguments := Array withAll: (Character space split: aShellCommandString).
]

{ #category : 'configuring' }
OSWSWinProcess >> shellCommand: aShellCommandName arguments: aListOfArguments [
	"This is a simple facility method for the cases when the user wants to use shell as the program.
	This way, the user can directly send shellCommand: 'ECHO' arguments: #('1 + 1' '>' 'a filename with spaces.txt')' 
	rather than having to do set the command cmd.exe, send the '/C' argument, etc etc etc."
	self shellCommand.
	arguments := OrderedCollection with: aShellCommandName.
	arguments addAll: aListOfArguments.
	arguments := arguments asArray.
]

{ #category : 'configuring' }
OSWSWinProcess >> shellCommandPath [
	^ 'C:\Windows\System32\cmd.exe'.
]

{ #category : 'configuring' }
OSWSWinProcess >> surroundArgumentsWithDoubleQuotes [
	surroundArgumentsWithDoubleQuotes := true.
]

{ #category : 'public' }
OSWSWinProcess >> terminate [
	| success |
	self isRunning ifFalse: [ ^ true ].
	
	success := self ffiLibrary 
		terminate: processInfo hProcess 
		exitCode: 3	"Kill the process, set a non-success exit code".
	success ifTrue: [ self clean ].
	^ success
]

{ #category : 'private' }
OSWSWinProcess >> waitForCompletion [
	self waitForCompletionTimeout: self class TIMEOUT_INFINITE.
]

{ #category : 'private' }
OSWSWinProcess >> waitForCompletionTimeout: nbMilliSeconds [
	| returnValue |
	[ returnValue := self ffiLibrary
		waitForSingleObject: processInfo hProcess
		milliSeconds: nbMilliSeconds.
	isRunning := false.
	returnValue = self class WAIT_OBJECT_0
		ifTrue: [ self setExitCode ].	"successful process termination"
	returnValue = self class WAIT_FAILED
		ifTrue: [ self setLastErrorCode ] ]
	ensure: [ self terminate ]
]

{ #category : 'private' }
OSWSWinProcess >> watch [
	(OSWSWinProcessWatcher on: self) watch
]

{ #category : 'configuring' }
OSWSWinProcess >> workingDirectory: aPathString [
	workingDirectory := aPathString
]

{ #category : 'private' }
OSWSWinProcess >> workingDirectoryHandle [
	^ workingDirectory 
		ifNil: [ ExternalAddress null ]
		ifNotNil: [ (Win32WideString fromString: workingDirectory) getHandle ]
]
