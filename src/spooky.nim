import spooky/utils, strutils, os, re, sequtils, tables, terminal

var
  marker: int = 1
  varMap = initTable[string, pointer]()

proc parseConfig(content: seq[string]) =
  for i in content:
    if i == "":
      continue
    colorEcho("$1:" % i, fgBlue)
    var input: string = readLine(stdin)
    varMap.add($input, marker.addr)

proc main =
  echo """
       .-.
      (o.o)
       |=|
      __|__
    //.=|=.\\
   // .=|=. \\
   \\ .=|=. //
    \\(_=_)//
     (:| |:)
      || ||
      () ()
      || ||
      || ||
     ==' '==
                                    __
  .-----. .-----. .-----. .-----. |  |--. .--.--.
  |__ --| |  _  | |  _  | |  _  | |    <  |  |  |
  |_____| |   __| |_____| |_____| |__|__| |___  |
          |__|                            |_____|
  """

  colorEcho("What is your project name?",fgYellow)

  var projectName: string = readLine(stdin)


  colorEcho("Are you using a pre-made template? (y/n)",fgYellow)

  var useTemplate: string = readLine(stdin)

  if useTemplate == "y":
    colorEcho("Enter repository url or template directory path", fgYellow)
    var templatePath: string = readLine(stdin)
    if templatePath.contains("http") or templatePath.contains("git@"):
      discard execShellCmd("git clone $1 $2" % [templatePath, projectName])
      setCurrentDir("./$1" % projectName)
      discard execShellCmd("rm -rf .git")
    else:
      templatePath.removePrefix({'"'})
      templatePath.removeSuffix({'"'})
      if fileExists("$1/bones" % templatePath):
        parseConfig(toSeq(lines("$1/bones" % templatePath)))
        copyDir(templatePath, "./$1" % projectName)
        for file in walkDirRec("./$1" % projectName):
          for varName in varMap.keys():
            echo "{{ $1 }}" % varName
            var fileLines: seq[string] = toSeq(lines(file))
            if fileLines.anyIt(contains(it, varName)):
              for line in fileLines:
                replaceVars(line, varName)
                # TODO write file with new contents


  else:
    echo "What tech are you using?"
    echo "(1) Node"

    var tech: string = readLine(stdin)
    if tech == "1":
      nodeProject(projectName)
    else:
      echo "Unsupported type"

main()
