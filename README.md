# OSWinSubprocess
OSSubprocess is a project that allows the user to spawn Windows System processes from within Pharo language. The main usage of forking external OS processes is to execute OS commands (.e.g dir, copy, etc) as well as arbitrary commands (.e.g C:\Users\me\myscript.bat or pharo.exe) from Pharo. This library uses the [Windows API](https://docs.microsoft.com/en-us/windows/desktop/api/processthreadsapi/nf-processthreadsapi-createprocessw) to create process from both 32-bit and 64-bit Pharo images. It also supports Unicode characters.

OSWinSubprocess name is really closed to the name of the [OSSubprocess projet](https://github.com/pharo-contributions/OSSubprocess) that allows to spawn external Unix or OS X processes. OSWinSubprocess and OSSubprocess are complementary and share a part of the API. A mid-term goal would be to unify these projects under the same umbrella.

Important note: As of now, this library does not yet support standard streams (stdin, stdout and stderr). It could be done by setting the appropriate information in the [STARTUPINFO structutre](https://docs.microsoft.com/fr-fr/windows/desktop/api/processthreadsapi/ns-processthreadsapi-_startupinfoa).

## Authors
* **Keldon Alleyne** - *Initial binding to the Windows API through FFI* - [Keldon Alleyne](https://github.com/avasopht)
* **Christophe Demarey** - *Initial work* - [Christophe Demarey](https://github.com/demarey)

See also the list of [contributors](https://github.com/pharo-contributions/OSWinSubprocess/contributors) who participated in this project.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments
* OSWinSubprocess took inspiration from the [ProcessWrapper](http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/) project ([source code](http://leves.web.elte.hu/ProcessWrapper)).
