# Endeavor Web Framework
### Status 

* Stable

## Overview 

Endeavor is a web framework written in Dart programming language and is inspired by frameworks like [Ruby on Rails](https://rubyonrails.org), and [Express Js](https://expressjs.com).

The goal of Endeavor framework is to provide developers effectively build backends in Dart. Currently, Dart is mainly used for developing client-side apps using Flutter. Our idea is to use Dart language for developing server-side applications also.  

## Quick Start 

### Prerequisites 

In order to use Endeavor you must have the [Dart SDK][dart_installation_link] installed on your machine.

This repository contains only core of Endeavor framework. There is no installation from this repo. So in order to use this framework , kindly use below instructions.

Endeavor requires Dart `">=2.17.0 <3.0.0"`


### Installing Endeavor CLI Tool 

```shell
#  Install the Endeavor cli from pub.dev

dart pub global activate ectl

```

### Creating a New Project 

Use the `ectl create <project name>` command to create a new project.

```shell
#  Create a new project called "MyDreamProject"
ectl create MyDreamProject
```

The directory structure is as follows:

```text
MyDreamProject
└── templates
    └── Home_view.dart
└── Controllers
    └── Home.dart
├── pubspec.yaml
├── main.dart
└── isolator.dart
```

### Start the Development Server

Next, open the newly directory of created project and start the dev server by:

```shell
#  Start the development server
ectl dev
```


By default port `80` is used. A custom port can be used inside the app's port option.

## Documentation

For detailed documentation, use our [documentation website](https://x-i-f-r-a.github.io/Endeavor-docs/)


## Versioning

Endeavor Framework is released by following the standard Semantic Versioning.


## Security Vulnerabilities or Bugs

If you discover a security vulnerability or bugs within Endeavor Framework, please send an e-mail to Gokul krishnan via gokulkrishnan5058@gmail.com. All security vulnerabilities and bugs will be promptly addressed.

## License

Endeavor Framework  is released under the BSD 3-Clause License.

[dart_installation_link]: https://dart.dev/get-dart
