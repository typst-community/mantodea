#import "_pkg.typ"

#let _content = content
#let _color = color
#let _gradient = gradient
#let _version = version

#import _pkg.z: *

#let paint = base-type.with(name: "color/gradient", types: (_color, _gradient,))

#let auto_ = base-type.with(name: "auto", types: (type(auto),))
