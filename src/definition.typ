///
#let definitions = state("__mantodea:def:definitions", (:))

///
#let handlers = state("__mantodea:def:handlers", (:))

#let ctx = (
  def: "def",
  ref: "ref",
)

/// Add a definition.
#let add-definition(key, type, value) = {
  definitions.update(d => {
    d.insert(key, (
      type: type,
      value: value,
    ))
    d
  })
}

/// Get a definition.
///
/// This function is contextual.
#let get-definition(key) = {
  let definitions = definitions.final()
  if key not in definitions {
    panic("no definition for `" + key + "` found")
  }

  definitions.at(key)
}

/// Add definition handlers.
#let add-handler(type, def, ref) = {
  handlers.update(h => h + ((type): (def: def, ref: ref)))
}

/// Get a definition handler.
///
/// This function is contextual.
#let get-handler(type, ctx) = {
  let handlers = handlers.final()
  if type not in handlers {
    panic("no handler for type `" + type + "` found")
  }

  let handler = handlers.at(type)
  if ctx not in handler {
    panic("no handler for context `" + ctx + "` found")
  }

  handler.at(ctx)
}

/// Retrieve and handle a definition.
///
/// This function is contextual.
#let handle(key, ctx) = {
  let def = get-definition(key)
  let handler = get-handler(def.type, ctx)

  handler(def.value)
}

/// Add and handle a definition.
#let define(key, type, value) = {
  add-definition(key, type, value)
  context handle(key, ctx.def)
}
