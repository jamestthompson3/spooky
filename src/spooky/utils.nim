import os, system, strutils, terminal

include nodeBuilds

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

template colorEcho*(s: string, fg: ForegroundColor) =
  setForeGroundColor(fg, true)
  s.writeStyled({})
  resetAttributes()
  echo ""

proc replaceVars*(line: string, varName: string) =
 echo line
