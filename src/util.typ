#import "/src/_pkg.typ"

/// Draw an alert box.
///
/// - color (color): The color to use for the box and text color.
/// - size (size): The text size to use.
/// - ..args (any): Additional arguments to pass to `showybox`.
/// - body (content): The box body.
/// -> content
#let alert(
  color: purple,
  size: 0.8em,
  _validate: true,
  ..args,
  body,
) = {
  if _validate {
    import _pkg: z
    // NOTE: intentionally left empty, we only validte our own inputs
  }

  _pkg.showybox.showybox(
    width: 100%,
    frame: (
      border-color: color,
      title-color: color,
      body-color: color.lighten(88%),
      thickness: (left: 2pt, rest: 0pt),
      radius: 0pt,
      inset: 8pt,
    ),
    ..args,
    text(size: size, fill: color.darken(60%), body),
  )
}

/// Draw a blue alert box. See `alert`.
#let hint = alert.with(color: blue)

/// Draw a green alert box. See `alert`.
#let info = alert.with(color: green)

/// Draw a yellow alert box. See `alert`.
#let warn = alert.with(color: yellow)

/// Draw a red alert box. See `alert`.
#let error = alert.with(color: red)
