import os, system, strutils

# TODO move configs to separate files reflecting more project options
const webpack = """
const path = require('path')

module.exports = {
  mode: 'development',
  entry: ['@babel/polyfill', './src/front/src/index.js'],
  output: {
    /* eslint-disable-next-line */
    path: __dirname,
    filename: './src/front/bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader']
      }
    ]
  },
  resolve: {
    /* eslint-disable-next-line */
    modules: [path.resolve(__dirname, 'src/front/src'), 'node_modules']
  },
  target: 'web'
}
"""

const eslint = """
{
  "parser": "babel-eslint",
  "parserOptions": {
    "ecmaVersion": 6,
    "sourceType": "module",
    "ecmaFeatures": {
      "arrowFunctions": true,
      "binaryLiterals": true,
      "blockBindings": true,
      "classes": true,
      "defaultParams": true,
      "destructuring": true,
      "experimentalObjectRestSpread": true,
      "restParams": true,
      "forOf": true,
      "generators": true,
      "modules": false,
      "objectLiteralComputedProperties": true,
      "objectLiteralDuplicateProperties": true,
      "objectLiteralShorthandMethods": true,
      "objectLiteralShorthandProperties": true,
      "octalLiterals": true,
      "regexUFlag": true,
      "regexYFlag": true,
      "spread": true,
      "superInFunctions": true,
      "templateStrings": true,
      "unicodeCodePointEscapes": true,
      "globalReturn": true,
      "jsx": true
    }
  },
  "env": {
    "es6": true,
    "browser": true,
    "commonjs": true,
    "jest": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:react/recommended",
  ],
    "rules": {
    "default-case": 1,
    "eqeqeq": 1,
    "no-unused-expressions": [1, { "allowShortCircuit": true, "allowTernary": true }],
    "no-useless-return": 1,
    "no-unused-vars": 1,
    "no-undef": 1,
    "eol-last": [2, "always"],
    "lines-between-class-members": 1,
    "padding-line-between-statements": [
      1,
      { "blankLine": "always", "prev": ["block-like", "export", "function", "multiline-expression"], "next": "*" },
      { "blankLine": "always", "prev": "*", "next": ["block-like", "export", "function"] },
      { "blankLine": "any", "prev": ["export", "case", "default"], "next": ["export", "case", "default"] }
    ],
    "no-unneeded-ternary": 1,
    "strict": [2, "safe"],
    "prefer-spread": 1,
    "brace-style": [2, "1tbs", { "allowSingleLine": true }],
    "no-trailing-spaces": 2,
    "keyword-spacing": 2,
    "spaced-comment": [2, "always"],
    "vars-on-top": 2,
    "guard-for-in": 2,
    "no-eval": 2,
    "no-with": 2,
    "no-continue": 1,
    "prefer-const": 2,
    "no-console": 0,
    "no-alert": 2,
    "react/prefer-es6-class": 1,
    "react/prop-types": 0,
    "react/prefer-stateless-function": 1,
    "react/no-unescaped-entities": [1, { "forbid": [">", "}"] }]
  }
}
"""

const serverEslint = """
{
  "parser": "babel-eslint",
  "parserOptions": {
    "ecmaVersion": 6,
    "sourceType": "module",
    "ecmaFeatures": {
      "arrowFunctions": true,
      "binaryLiterals": true,
      "blockBindings": true,
      "classes": true,
      "defaultParams": true,
      "destructuring": true,
      "experimentalObjectRestSpread": true,
      "restParams": true,
      "forOf": true,
      "generators": true,
      "modules": false,
      "objectLiteralComputedProperties": true,
      "objectLiteralDuplicateProperties": true,
      "objectLiteralShorthandMethods": true,
      "objectLiteralShorthandProperties": true,
      "octalLiterals": true,
      "regexUFlag": true,
      "regexYFlag": true,
      "spread": true,
      "superInFunctions": true,
      "templateStrings": true,
      "unicodeCodePointEscapes": true,
      "globalReturn": true,
    }
  },
  "env": {
    "es6": true,
    "browser": true,
    "commonjs": true,
    "jest": true
  },
  "extends": [
    "eslint:recommended",
  ],
    "rules": {
    "default-case": 1,
    "eqeqeq": 1,
    "no-unused-expressions": [1, { "allowShortCircuit": true, "allowTernary": true }],
    "no-useless-return": 1,
    "no-unused-vars": 1,
    "no-undef": 1,
    "eol-last": [2, "always"],
    "lines-between-class-members": 1,
    "padding-line-between-statements": [
      1,
      { "blankLine": "always", "prev": ["block-like", "export", "function", "multiline-expression"], "next": "*" },
      { "blankLine": "always", "prev": "*", "next": ["block-like", "export", "function"] },
      { "blankLine": "any", "prev": ["export", "case", "default"], "next": ["export", "case", "default"] }
    ],
    "no-unneeded-ternary": 1,
    "strict": [2, "safe"],
    "prefer-spread": 1,
    "brace-style": [2, "1tbs", { "allowSingleLine": true }],
    "no-trailing-spaces": 2,
    "keyword-spacing": 2,
    "spaced-comment": [2, "always"],
    "vars-on-top": 2,
    "guard-for-in": 2,
    "no-eval": 2,
    "no-with": 2,
    "no-continue": 1,
    "prefer-const": 2,
    "no-console": 0,
    "no-alert": 2,
  }
}
"""


const prettier = """
{
  "printWidth": 100,
  "semi": false,
  "singleQuote": true
}
"""

const serverBabel = """
{
  presets: ["@babel/preset-env"],
  plugins: ["@babel/plugin-proposal-class-properties"]
}
"""

const babel = """
{
  presets: ["@babel/preset-react", "@babel/preset-env"],
  plugins: ["@babel/plugin-proposal-class-properties", "babel-plugin-styled-components"]
}
"""


const serverPackage = """
{
  "name": "my-node-app",
  "version": "0.0.1",
  "license": "MIT",
  "scripts": {
    "dev": "nodemon start.js",
    "start": "node start.js"
  }
}
"""

const package = """
{
  "name": "my-node-app",
  "version": "0.0.1",
  "license": "MIT",
  "scripts": {
    "dev": "node startDev.js",
    "start": "node start.js"
  }
}
"""


const start = """
// Using ES6 because it's 2018.
require('@babel/register')({
  extends: './.babelrc',
  ignore: [/node_modules/]
})

module.exports = require('./src/server.js')
"""

const serverOnly = """
import express from 'express'
import bodyParser from 'body-parser'
import compression from 'compression'

const app = express()

/* eslint-disable-next-line */
const PORT = process.NODE_ENV === 'production' ? 80 : 8080

app.use(bodyParser.urlencoded({ extended: true }))
app.use(compression())

app.get('*', (req, res) => {
  res.sendStatus(200)
})

app.listen(PORT, () => console.log(`🚀  Absolutely EPIC on port ${PORT}!`))
"""

const clientServer = """
import express from 'express'
import bodyParser from 'body-parser'
import path from 'path'
import compression from 'compression'

const app = express()

/* eslint-disable-next-line */
const PORT = process.NODE_ENV === 'production' ? 80 : 8080

app.use(bodyParser.urlencoded({ extended: true }))
app.use(compression())
/* eslint-disable-next-line */
app.use(express.static(path.join(__dirname, 'front')))

app.get('*', (req, res) => {
  /* eslint-disable-next-line */
  res.sendFile(path.join(__dirname, 'front/index.html'))
})

app.listen(PORT, () => console.log(`🚀  Absolutely EPIC on port ${PORT}!`))
"""


const readme = """
This project was bootstrapped by spooky

# Getting started
 `yarn dev` or `npm dev` starts the server in development mode

 `yarn start` or `npm start` starts the server in production mode
"""


const startDev = """
const { exec } = require('child_process')

const webpack = exec('yarn webpack -w --config=webpack.config.js')
const nodemon = exec('yarn nodemon start.js --ignore src/front')

webpack.stdout.on('data', data => {
  console.log(data)
})

webpack.stderr.on('data', data => {
  console.log(`webpack error: ${data}`)
})

webpack.on('close', code => {
  console.log(`webpack process exited with code ${code}`)
})

nodemon.stdout.on('data', data => {
  console.log(data)
})

nodemon.stderr.on('data', data => {
  console.log(`nodemon error: ${data}`)
})

nodemon.on('close', code => {
  console.log(`nodemon process exited with code ${code}`)
})
"""

const index = """
<!DOCTYPE html>
<html>
<head>
  <title>Node App</title>
  <meta charset='utf-8'>
  <meta name='viewport' content='width=device-width initial-scale=1.0'>
  <meta name="mobile-web-app-capable" content="yes">
  <base href="/">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <link rel="apple-touch-icon" sizes="180x180" href="icon.png">
  <link rel="icon" type="image/png" sizes="180x180" href="icon.png">
</head>
  <body>
    <div id="root"></div>
    <script defer src="bundle.js"></script>
  </body>
</html>
"""

const indexJs = """
import React from 'react'
import { render } from 'react-dom'

import { App } from './App'

render(<App />, document.getElementById('root'))
"""

const app = """
import React from 'react'

export const App = () => <h1>Hello, World!</h1>
"""

const serverDeps: string = join(["body-parser", "compression", "express", "lodash", "superagent"], " ")
const serverDevDeps: string = join([
    "@babel/cli",
    "@babel/core",
    "@babel/plugin-proposal-class-properties",
    "@babel/polyfill",
    "@babel/preset-env",
    "@babel/register",
    "babel-eslint",
    "eslint",
    "eslint-plugin-react",
    "nodemon"
], " ")

const clientDeps: string = join([
    "polished",
    "query-string",
    "react",
    "react-custom-scrollbars",
    "react-dom",
    "react-router-dom",
    "react-select",
    "react-virtualized",
    "styled-components"
], " ")

const clientDevDeps: string = join([
    "@babel/preset-react",
    "babel-loader",
    "babel-plugin-styled-components",
    "css-loader",
    "eslint-plugin-react",
    "style-loader",
    "webpack",
    "webpack-cli"
], " ")

proc install(deps: string, devDeps: string) =
  if execShellCmd(deps) == 1:
    echo "Error installing dependencies"
  if execShellCmd(devDeps) == 1:
    echo "Error installing dev dependencies"

proc buildServer(projectName: string, packageManager: string) =
  var currDir = getCurrentDir()
  createDir("$1/$2" % [currDir,projectName])
  setCurrentDir("./$1" % projectName)
  writeFile("./.babelrc", serverBabel)
  writeFile("./.eslintrc", serverEslint)
  writeFile("./.prettierrc", prettier)
  writeFile("./package.json", serverPackage)
  writeFile("./start.js", start)
  writeFile("./README.md", readme)
  createDir("$1/src" % [currDir])
  writeFile("$1/src/server.js" % [currDir], serverOnly)

  if packageManager == "1":
    const installDeps: string = join(["npm install",serverDeps], " ")
    const installDevDeps: string = join(["npm install",serverDevDeps, "--save-dev"], " ")
    install(installDeps, installDevDeps)
  else:
    const installDeps: string = join(["yarn add",serverDeps], " ")
    const installDevDeps: string = join(["yarn add -D",serverDevDeps], " ")
    install(installDeps, installDevDeps)

proc buildClient(projectName: string, packageManager: string) =
  createDir("$1/$2" % [getCurrentDir(),projectName])
  setCurrentDir("./$1" % projectName)
  writeFile("./.babelrc", babel)
  writeFile("./.eslintrc", eslint)
  writeFile("./webpack.config.js", webpack)
  writeFile("./.prettierrc", prettier)
  writeFile("./package.json", package)
  writeFile("./startDev.js", startDev)
  writeFile("./start.js", start)
  writeFile("./README.md", readme)
  createDir("$1/src" % [getCurrentDir()])
  createDir("$1/src/front" % [getCurrentDir()])
  createDir("$1/src/front/src" % [getCurrentDir()])
  writeFile("$1/src/server.js" % [getCurrentDir()], clientServer)
  writeFile("$1/src/front/index.html" % [getCurrentDir()], index)
  writeFile("$1/src/front/src/index.js" % [getCurrentDir()], indexJs)
  writeFile("$1/src/front/src/App.js" % [getCurrentDir()], app)

  if packageManager == "1":
    const installDeps: string = join(["npm install",serverDeps, clientDeps], " ")
    const installDevDeps: string = join(["npm install",serverDevDeps,clientDevDeps, "--save-dev"], " ")
    install(installDeps, installDevDeps)
  else:
    const installDeps: string = join(["yarn add",serverDeps, clientDeps], " ")
    const installDevDeps: string = join(["yarn add -D",serverDevDeps, clientDevDeps], " ")
    install(installDeps, installDevDeps)


proc nodeProject*(projectName: string) =
  echo "Select: (1) Server only (2) Fullstack with React"
  var nodeType: string = readLine(stdin)
  echo "Select package manager (1) npm (2) yarn"
  var packageManager: string = readLine(stdin)
  if nodeType == "1":
    buildServer(projectName, packageManager)
  else:
    buildClient(projectName, packageManager)

