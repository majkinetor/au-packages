# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/plantuml/icon.png" width="48" height="48"/> [![](https://img.shields.io/chocolatey/v/plantuml.svg?color=red&label=plantuml)](https://chocolatey.org/packages/plantuml)

PlantUML is an open-source tool allowing users to create UML and other diagrams from a plain text language. Diagrams are defined using a simple and intuitive language. This can be used within many other tools. Images can be generated in PNG, in SVG or LaTeX format. It is also possible to generate ASCII art diagrams (only for sequence diagrams).

Try it online using [plantuml online server](http://www.plantuml.com/plantuml).

## Features

- [Sequence diagram](http://plantuml.com/sequence.html)
- [Use case diagram](http://plantuml.com/usecase.html)
- [Class diagram](http://plantuml.com/classes.html)
- [Activity diagram](http://plantuml.com/activity2.html)
- [Component diagram](http://plantuml.com/component.html)
- [State diagram](http://plantuml.com/state.html)
- [Object diagram](http://plantuml.com/objects.html)
- [Deployment diagram](http://plantuml.com/deployment.html)
- [Timing diagram](http://plantuml.com/timing-diagram)
- [Wireframe graphical interface](http://plantuml.com/salt.html)
- [Archimate diagram](http://plantuml.com/timing-diagram)
- [Specification and Description Language (SDL)](http://plantuml.com/activity-diagram-beta#sdl)
- [Ditaa diagram](http://plantuml.com/ditaa)
- [Gantt diagram](http://plantuml.com/gantt-diagram)
- [Mathematic with AsciiMath or JLaTeXMath notation](http://plantuml.com/ascii-math)

## Package parameters

- `/NoShortcuts` - Do not create desktop shortcuts for plantuml and its manual.

## Notes

- This package creates two shims - `plantuml` (invoked via `javaw`) and `plantumlc` (invoked via `java`). The later one should be used with scripting. See available command line options with `plantumlc -help`. For example, to convert entire directory of plantuml files to images recursivelly, you can use `plantumlc -r -tsvg **\*.puml`.

![screenshot](https://cdn.rawgit.com/majkinetor/chocolatey/master/plantuml/screenshot.png)
