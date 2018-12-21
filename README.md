# Spooky

## Usage

After compiling the source code, just add the executable to your path and run `spooky`

## Config files

If you are using a project template, Spooky will look for
a config file named `bones` in the template directory. This should contain all the dynamic
variables you wish to inject into your project.

#### Example

```toml
# the pound sign is regarded as a comment in bones files
# bones

deployment_target
aws_resource_group
project_name
```

```json
// package.json
{
  "name": "{{ project_name }}"
}
```

```toml
# in gitlab CI or other such files
resource_group: {{ aws_resource_group }}
```

Spooky will read the bones file and then replace the corresponding values
wherever they occur inside of your template directory.

## Building

`cd spooky && nim c -d:release -o:spooky src/spooky.nim`
