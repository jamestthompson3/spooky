import spooky/utils, strutils, os, sequtils, terminal


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
      parseTemplate(projectName)
    else:
      templatePath.removePrefix({'"'})
      templatePath.removeSuffix({'"'})
      copyDir(templatePath, "./$1" % projectName)
      setCurrentDir("./$1" % projectName)
      parseTemplate(projectName)
  else:
    echo "What tech are you using?"
    echo "(1) Node"

    var tech: string = readLine(stdin)
    if tech == "1":
      nodeProject(projectName)
    else:
      echo "Unsupported type"

main()
