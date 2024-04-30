# Features

- support [[#file macro]].
- support [[#file building]].
- support [[#building to specific path]].


# Strategies
## file macro
This API allows users to setup the filename according to the class name and extension.

## file building
This API will let users to build a file through the lib: `ruby::FileOperator`, other ruby classes will inherit from this:
- `ruby::SVClass`
- `ruby::SVInterface`
- `ruby::SVModule`
- ...


## building to specific path
This `ruby::SVFile` provides a 'path' API for users to build separated files into different paths.