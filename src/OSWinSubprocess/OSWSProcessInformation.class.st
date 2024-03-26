"
Structure needed to make FFI calls to createProcess.
It contains information about a newly created process and its primary thread.
See PhLProcess class for more information.
documentation: https://docs.microsoft.com/en-us/windows/desktop/api/processthreadsapi/ns-processthreadsapi-process_information
"
Class {
	#name : #OSWSProcessInformation,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_DWPROCESSID',
		'OFFSET_DWTHREADID',
		'OFFSET_HPROCESS',
		'OFFSET_HTHREAD'
	],
	#pools : [
		'OSWSWinTypes'
	],
	#category : #OSWinSubprocess
}

{ #category : #'field definition' }
OSWSProcessInformation class >> fieldsDesc [
	"self rebuildFieldAccessors"
	
	^ #(
	HANDLE hProcess;
	HANDLE hThread;
	DWORD  dwProcessId;
	DWORD  dwThreadId;	
	)
]

{ #category : #'accessing structure variables' }
OSWSProcessInformation >> dwProcessId [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWPROCESSID
]

{ #category : #'accessing structure variables' }
OSWSProcessInformation >> dwProcessId: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWPROCESSID put: anObject
]

{ #category : #'accessing structure variables' }
OSWSProcessInformation >> dwThreadId [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWTHREADID
]

{ #category : #'accessing structure variables' }
OSWSProcessInformation >> dwThreadId: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWTHREADID put: anObject
]

{ #category : #'accessing structure variables' }
OSWSProcessInformation >> hProcess [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HPROCESS) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
OSWSProcessInformation >> hProcess: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HPROCESS put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
OSWSProcessInformation >> hThread [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HTHREAD) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
OSWSProcessInformation >> hThread: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HTHREAD put: anObject getHandle.
]

{ #category : #initialization }
OSWSProcessInformation >> initialize [
	super initialize.
	OSWSWinProcessLibrary clear: self
]
