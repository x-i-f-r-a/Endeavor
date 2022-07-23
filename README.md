# Momentum Web Framework
## Overview 

Momentum is a web framework written in Dart programming language and is inspired by frameworks like [Laravel](https://laravel.com), [Ruby on Rails](https://rubyonrails.org), and [Express Js](https://expressjs.com).

The goal of Momentum web framework is to provide developers effectively build backends in Dart. Currently, Dart is mainly used for developing client-side apps using Flutter. Our idea is to use Dart language for developing server-side applications also.  

## Quick Start 

### Prerequisites 

In order to use Momentum Web Framework you must have the [Dart SDK][dart_installation_link] installed on your machine.


Momentum requires Dart `">=2.17.0 <3.0.0"`


### Installing Momentum CLI Tool 

```shell
#  Install the moment cli from pub.dev

dart pub global activate moment

```

### Creating a New Project 

Use the `moment create <project name>` command to create a new project.

```shell
#  Create a new project called "MyDreamProject"
moment create MyDreamProject
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
moment dev
```


By default port `80` is used. A custom port can be used inside the app's port option.

## Documentation

For detailed documentation, use our [documentation website](https://x-i-f-r-a.github.io/Momentum-docs/)


## Versioning

Momentum Web Framework is released by following the standard Semantic Versioning.


## Security Vulnerabilities or Bugs

If you discover a security vulnerability or bugs within Momentum Web Framework, please send an e-mail to Gokul krishnan via gokulkrishnan@gmail.com. All security vulnerabilities and bugs will be promptly addressed.

## License

Momentum framework  is released under the BSD 3-Clause License.

[dart_installation_link]: https://dart.dev/get-dart
