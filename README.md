makefile jinja2 demo
====================

### Purpose

A small demo illustrating how we can generate a bunch of config files from Jinja2 templates in a dependency aware file-driven fashion using a good old `Makefile`.

### Dependencies

*	GNU Make or anything approximately compatible (e.g. [pymake](https://github.com/mozilla/pymake)).
*	`python`, with `Jinja2` and `PyYAML`.

### Running the demo

run `make`

### What is `scripts/rj2.py` for?

`rj2.py` is a python script to render a single input Jinja2 template with respect to some given "context" object full of variables that can be used during template rendering. It only renders one template at a time, to force you to drive your rendering using the `Makefile`, so `make` is aware of the file dependencies.

### What is `scripts/gen_targets.py` for?

`gen_targets.py` is a crude python script to derive target filenames from dependency filenames according to a single given `make` pattern rule, and matching dependency files found on disk.

It is used to generate build targets, so we can easily tell `make` that we want to build all rendered config files that have a one-to-one relationship via the given pattern rule with a Jinja2 template in our templates directory. GNU Make doesn't have built-in functionality to do this easily (for example: it can handle replacing path suffixes, but lacks support for easily handling path prefixes).

No claim is made that `gen_targets.py` understands GNU Make pattern rules in general, but it appears to work for this demo!

### Dockerised demo

Use of `docker` is completely optional, but provides a standard environment with enough dependencies to run the demo.

With `docker` installed, and an internet connection, you can run the demo by building the `Dockerfile`:

```
docker build -t demo:latest -f Dockerfile .
```
