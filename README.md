# ichat2json

Reads an .ichat binary plist file and writes newline-separated JSON to STDOUT

##  Run Instructions

- Open ichat2json.xcodeproj with Xcode.
- Build it.
- In console you'll find the path of the executable.

Console:
```console
Usage:  /Users/[YOURUSER]/Library/Developer/Xcode/DerivedData/ichat2json-fgxipssxrjlhvrevepwucnmapdzq/Build/Products/Debug/ichat2json path/to/ichat
```

Copy the path, and use this command in a Terminal to dump it in a file:

EX:
```bash
cd /PATH_TO_YOUR_ICHAT_FILE
/Users/[YOURUSER]/Library/Developer/Xcode/DerivedData/ichat2json-fgxipssxrjlhvrevepwucnmapdzq/Build/Products/Debug/ichat2json file.ichat > file.json
```


## Special Thanks

* [Jonathan](https://github.com/jmah) for [iChat-Image-Indexer](https://github.com/jmah/iChat-Image-Indexer)
* [Karsten](https://github.com/karstenBriksoft) for [PlistExplorer](https://github.com/karstenBriksoft/PlistExplorer)
* [Gianni](https://github.com/unzsnu) for [Run Instructions](https://github.com/matrix-hacks/ichat2json/issues/3#issuecomment-583489932)
