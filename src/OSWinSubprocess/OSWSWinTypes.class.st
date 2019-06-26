"
Definition of Windows types used in prototypes of the functions needed to manage processes.
"
Class {
	#name : #OSWSWinTypes,
	#superclass : #SharedPool,
	#classVars : [
		'DWORD',
		'HANDLE',
		'LPBYTE',
		'LPCSTR',
		'LPCWSTR',
		'LPDWORD',
		'LPSTR',
		'LPVOID',
		'LPWSTR',
		'WORD'
	],
	#category : #OSWinSubprocess
}

{ #category : #'class initialization' }
OSWSWinTypes class >> initialize [ 
	DWORD := #uint32.
	HANDLE := 'void*'.
	LPSTR := String.
	LPCSTR := String.
	LPWSTR := 'void*'. "Cannot use Win32WideString directly because FFI will not accept null pointers"
	LPCWSTR := 'void*'. "Cannot use Win32WideString directly because FFI will not accept null pointers"
	LPVOID := 'void*'.
	WORD := #uint16.
	LPBYTE := 'char*'.
	LPDWORD := FFIExternalValueHolder ofType: #uint32.
]
