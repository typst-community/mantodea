#import "_pkg.typ"

#let _content = content
#let _color = color
#let _gradient = gradient
#let _label = label
#let _version = version

#import _pkg.z: *

#let paint = base-type.with(name: "color/gradient", types: (_color, _gradient,))

#let auto_ = base-type.with(name: "auto", types: (type(auto),))
#let label = base-type.with(name: "label", types: (_label,))
#let version = base-type.with(name: "version", types: (_version,))
