"
Structure needed to make FFI calls to createProcess.
Specifies the window station, desktop, standard handles, and appearance of the main window for a process at creation time.
See PhLWinProcess class for more information.
Documentation: https://docs.microsoft.com/fr-fr/windows/desktop/api/processthreadsapi/ns-processthreadsapi-_startupinfow
"
Class {
	#name : #OSWSStartupInfoW,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_CB',
		'OFFSET_CBRESERVED2',
		'OFFSET_DWFILLATTRIBUTE',
		'OFFSET_DWFLAGS',
		'OFFSET_DWX',
		'OFFSET_DWXCOUNTCHARS',
		'OFFSET_DWXSIZE',
		'OFFSET_DWY',
		'OFFSET_DWYCOUNTCHARS',
		'OFFSET_DWYSIZE',
		'OFFSET_HSTDERROR',
		'OFFSET_HSTDINPUT',
		'OFFSET_HSTDOUTPUT',
		'OFFSET_LPDESKTOP',
		'OFFSET_LPRESERVED',
		'OFFSET_LPRESERVED2',
		'OFFSET_LPTITLE',
		'OFFSET_WSHOWWINDOW'
	],
	#pools : [
		'OSWSWinTypes'
	],
	#category : #OSWinSubprocess
}

{ #category : #'field definition' }
OSWSStartupInfoW class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	DWORD	cb;
	LPWSTR	lpReserved;
	LPWSTR	lpDesktop;
	LPWSTR	lpTitle;
	DWORD	dwX;
	DWORD	dwY;
	DWORD	dwXSize;
	DWORD	dwYSize;
	DWORD	dwXCountChars;
	DWORD	dwYCountChars;
	DWORD	dwFillAttribute;
	DWORD	dwFlags;
	WORD	 wShowWindow;
	WORD	 cbReserved2;
	LPBYTE lpReserved2;
	HANDLE hStdInput;
	HANDLE hStdOutput;
	HANDLE hStdError;
)
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> cb [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_CB
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> cb: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_CB put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> cbReserved2 [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_CBRESERVED2
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> cbReserved2: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_CBRESERVED2 put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwFillAttribute [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWFILLATTRIBUTE
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwFillAttribute: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWFILLATTRIBUTE put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwFlags [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWFLAGS
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwFlags: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWFLAGS put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwX [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWX
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwX: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWX put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwXCountChars [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWXCOUNTCHARS
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwXCountChars: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWXCOUNTCHARS put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwXSize [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWXSIZE
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwXSize: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWXSIZE put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwY [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWY
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwY: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWY put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwYCountChars [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWYCOUNTCHARS
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwYCountChars: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWYCOUNTCHARS put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwYSize [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DWYSIZE
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> dwYSize: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DWYSIZE put: anObject
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> hStdError [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HSTDERROR) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> hStdError: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HSTDERROR put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> hStdInput [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HSTDINPUT) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> hStdInput: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HSTDINPUT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> hStdOutput [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_HSTDOUTPUT) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> hStdOutput: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_HSTDOUTPUT put: anObject getHandle.
]

{ #category : #initialization }
OSWSStartupInfoW >> initialize [
	super initialize.
	OSWSWinProcessLibrary clear: self
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> lpDesktop [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPDESKTOP) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> lpDesktop: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPDESKTOP put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> lpReserved [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPRESERVED) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> lpReserved2 [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPRESERVED2) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> lpReserved2: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPRESERVED2 put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> lpReserved: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPRESERVED put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> lpTitle [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LPTITLE) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> lpTitle: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LPTITLE put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> wShowWindow [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_WSHOWWINDOW
]

{ #category : #'accessing structure variables' }
OSWSStartupInfoW >> wShowWindow: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_WSHOWWINDOW put: anObject
]
