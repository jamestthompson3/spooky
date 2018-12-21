import os, system, strutils, terminal, sequtils, tables

include nodeBuilds

template colorEcho*(s: string, fg: ForegroundColor) =
  setForeGroundColor(fg, true)
  s.writeStyled({})
  resetAttributes()
  echo ""

proc parseConfig(content: seq[string]): Table[ string, string ] =
  var varMap = initTable[string, string]()
  for line in content:
    if line == "":
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

proc parseTemplate*(projectName: string) =
  if fileExists("./bones"):
    var varMap = parseConfig(toSeq(lines("./bones")))
    for file in walkDirRec("./$1" % projectName):
      for varName in varMap.keys():
        let replacementString = "{{ $1 }}" % varName
        file.writeFile file.readFile.replace(replacementString, varMap[varName])
    echo """
    ******************
    *                *
    * Ready to roll! *
    *                *
    ******************
    """
  else:
    echo "No config file found, exiting"



