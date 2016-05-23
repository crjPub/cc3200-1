# How to Build with `arm-none-eabi-` Toolchain in Cygwin

## Build in App Dir

```
$ cd project_root_dir
$ source envsetup.sh    (*MUST*, one time shot)
$ cd Apps/hello
$ make clean
$ make
- or -
$ make -f Makefile
```

## Build App from Top

```
$ cd project_root_dir
$ source envsetup.sh    (*MUST*, one time shot)
$ mmm Apps/hello

Usage:
  mmm [path] [option]
  - path   - relative path to Makefile (for an App) to be built with
  - option - target to make, eg clean, debug, release, etc
Example:
  mmm Apps/hello clean (* at top folder)
  mmm Apps/hello       (* at top folder)
  mmm . clean          (* at Apps/hello)
  mmm                  (* at Apps/hello)
```

## Build Modules

```
$ cd project_root_dir
$ source envsetup.sh    (*MUST*, one time shot)
$ mm apps

Usage:
  mm [module] [option]
  - module - A collection of Apps, SDK, OS, libs, etc
  - option - build command or option, eg clean, debug, release, etc
Example:
  mm apps clean
  mm sdk release
  mm libs
  mm
```

## Build All

```
$ cd project_root_dir
$ source envsetup.sh    (*MUST*, one time shot)
$ m

Usage:
  m [command] [config] [target]
  - command:
    - m / make [default]
    - b / build
    - r / rebuild
    - c / clean
  - config:
    - d / debug [default]
    - r / release
  - target:
    - all [default]
    - a / all
    - s / std
    - a / app
    - o / ota
Example:
  m m d a
  m c d
  m r
  m
```

## Reference

- [Android Build System](http://www.elinux.org/Android_Build_System)

