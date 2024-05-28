#import "/src/definition.typ"

#definition.add-handler(
  "function",
  it => block(stroke: gray, inset: 1em, {
    raw(it.name + "()")
    [#metadata(()) #label("func:" + it.name)]
    linebreak()
    for arg in it.args {
      definition.define(it.name + ":" + arg.name, "function:argument", arg)
    }
  }),
  it => link(label("func:" + it.name), raw(it.name + "()")),
)

#definition.add-handler(
  "function:argument",
  it => block(stroke: gray, width: 100%, inset: 1em, {
    raw(it.name)
    [#metadata(()) #label("arg:" + it.func + ":" + it.name)]
    linebreak()
    it.description
  }),
  it => link(label("arg:" + it.func + ":" + it.name), raw(it.func + "." +  it.name)),
)

#definition.define("func", "function", (
  name: "func",
  args: (
    (
      func: "func",
      name: "arg1",
      description: "First argument of function func.",
    ),
    (
      func: "func",
      name: "arg2",
      description: "Second argument of function func.",
    ),
  ),
))

#show ref: it => {
  let target = str(it.target)
  if target in definition.definitions.final() {
    box(stroke: red, definition.handle(target, definition.ctx.ref))
  } else {
    it
  }
}

@func

@func:arg1

@func:arg2
