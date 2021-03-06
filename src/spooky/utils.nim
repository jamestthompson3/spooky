import os, system, strutils, terminal, sequtils, tables

include nodeBuilds, nimBuilds

template colorEcho*(s: string, fg: ForegroundColor) =
  setForeGroundColor(fg, true)
  s.writeStyled({})
  resetAttributes()
  echo ""

proc success() =
  echo """

      ******************
      *                *
      * Ready to roll! *
      *                *
      ******************
      """

proc parseConfig(content: seq[string]): Table[ string, string ] =
  var varMap = initTable[string, string]()
  for line in content:
    if line == "" or line.contains("#"):
      continue
    colorEcho("$1:" % line, fgBlue)
    var input: string = readLine(stdin)
    varMap.add(line, input)
  return varMap

proc install(deps: string, devDeps: string) =
  if execShellCmd(deps) == 1:
    echo "Error installing dependencies"
  if execShellCmd(devDeps) == 1:
    echo "Error installing dev dependencies"


proc nodeProject*(projectName: string) =
  echo "Select: (1) Server only (2) Fullstack with React"
  var nodeType: string = readLine(stdin)
  echo "Select package manager (1) npm (2) yarn"
  var packageManager: string = readLine(stdin)
  if nodeType == "1":
    buildServer(projectName, packageManager, install)
  else:
    buildClient(projectName, packageManager, install)
  success()

proc nimProject*(projectName: string) =
  createDir("$1/$2/src" % [getCurrentDir(),projectName])
  setCurrentDir("$1/$2" % [getCurrentDir(), projectName])
  writeFile("./src/$1.nim" % projectName, src)
  success()

proc parseTemplate*(projectName: string) =
  if fileExists("./bones"):
    var varMap = parseConfig(toSeq(lines("./bones")))
    for file in walkDirRec("./"):
      if file.contains("bones"):
        continue
      var fileLines: seq[string] = toSeq(lines(file))
      for varName in varMap.keys():
        let replacementString = "{{ $1 }}" % varName
        if fileLines.anyIt(it.contains(replacementString)):
          echo file
          fileLines = fileLines.mapIt(it.replace(replacementString, varMap[varName]))
      file.writeFile foldl(fileLines, a & b)
    success()
  else:
    echo "No config file found, exiting"

