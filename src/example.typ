#import "/src/_pkg.typ"
#import "/src/_valid.typ"
#import "/src/theme.typ" as _theme

/// Show a source code frame.
///
/// - theme (theme): The theme to use for this code frame.
/// - ..args (any): The args to pass to `showybox`.
/// -> content
#let frame(
  theme: _theme.default,
  _validate: true,
  ..args,
) = {
  if _validate {
    import _valid as z
    _ = z.parse(theme, _theme.schema(), scope: ("theme",))
    // NOTE: intentionally left empty, we only validte our own inputs
  }

  _pkg.showybox.showybox(
    frame: (
      border-color: theme.colors.primary,
      title-color: theme.colors.primary,
      thickness: .75pt,
      radius: 4pt,
      inset: 8pt
    ),
    ..args
  )
}

/// Shows example code and its corresponding output in a frame.
///
/// - side-by-side (bool): Whether or not the example source and output should
///   be shown side by side.
/// - scope (dictionary): The scope to pass to `eval`.
/// - breakable (bool): If the frame can brake over multiple pages.
/// - result (content): The content to render as the example result. Evaluated
///  `eval`.
/// - source (content): A raw element containing the source code to evaluate.
/// - theme (theme): The theme to use for this code example.
/// -> content
#let code-result(
  side-by-side: false,
  scope: (:),
  breakable: false,
  result: auto,
  source,
  theme: _theme.default,
  _validate: true,
) = {
  if _validate {
    import _valid as z
    _ = z.parse(side-by-side, z.boolean(), scope: ("side-by-side",))
    _ = z.parse(breakable, z.boolean(), scope: ("breakable",))
    _ = z.parse(scope, z.dictionary((:)), scope: ("scope",))
    _ = z.parse(result, z.either(z.content(), z.auto_()), scope: ("result",))
    _ = z.parse(source, z.content(), scope: ("source",))
    _ = z.parse(theme, _theme.schema(), scope: ("theme",))
  }

  let mode = if source.lang == "typc" {
    "code"
  } else if source.lang in ("typ", "typst") {
    "markup"
  } else if result == auto {
    panic("cannot evaluate " + source.lang + " code")
  }

  if result == auto {
    result = eval(mode: mode, scope: scope, source.text)
  }

  frame(
    breakable: breakable,
    theme: theme,
    grid(
      columns: if side-by-side { (1fr, 1fr) } else { (1fr,) },
      gutter: 12pt,
      source,
      if not side-by-side {
        grid.hline(stroke: 0.75pt + theme.colors.primary)
      },
      result,
    ),
  )
}
