import spooky/utils, strutils, os, re

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

echo "What is your project name?"

var projectName: string = readLine(stdin)


echo "Are you using a pre-made template? (y/n)"

var useTemplate: string = readLine(stdin)

if useTemplate == "y":
  echo "Enter repository url or template directory path"
  var templatePath: string = readLine(stdin)
  if templatePath.contains("http") or templatePath.contains("git@"):
    discard execShellCmd("git clone $1 $2" % [templatePath, projectName])
    setCurrentDir("./$1" % projectName)
    discard execShellCmd("rm -rf .git")
  else:
    templatePath.removePrefix({'"'})
    templatePath.removeSuffix({'"'})
    copyDir(templatePath, "./$1" % projectName)


else:
  echo "What tech are you using?"
  echo "(1) Node"

  var tech: string = readLine(stdin)
  if tech == "1":
    nodeProject(projectName)
  else:
    echo "Unsupported type"
