#import "/src/_pkg.typ"
#import "/src/_valid.typ"

/// The marks used in `author` for automatic mark numbering.
///
/// Can be used to add new or alter existing marks, marks come in the form of
/// arbitrary content which is placed as a superscript.
#let marks = state("__mantodea:author:marks", (
  marks: (:),
  current-auto: 0,
))

/// Display a person with the given options.
///
/// - short (int): The shortness level.
///   - `0`: do not shorten any names
///   - `1`: shorten middle names
///   - `2`: shorten middle and first names
/// - ..first (str): The first and middle names.
/// - last (str, array): The last names.
/// -> content
#let name(
  short: 1,
  ..first,
  last,
  _validate: true,
) = {
  if _validate {
    import _valid as z
    _ = z.parse(first, z.sink(positional: z.array(z.string())), scope: ("first",))
    _ = z.parse(last, z.array(z.string(), pre-transform: z.coerce.array), scope: ("last",))
    _ = z.parse(short, z.integer(min: 0, max: 2), scope: ("short",))
  }

  first = first.pos()

  if type(first) == str {
    first = (first,)
  }

  if type(last) == str {
    last = (last,)
  }

  let short = if first != () {
    let shorten(name) = name.clusters().first() + "."
    let (first, ..middle) = first

    if short > 0 {
      middle = middle.map(shorten)
    }

    if short > 1 {
      first = shorten(first)
    }

    (first, ..middle).join(" ")
  }

  if short != none {
    short
    [ ]
  }

  smallcaps(last.join(" "))
}

/// Show full author information, see also `name`.
///
/// - short (int): The shortness level.
///   - `0`: do not shorten any names
///   - `1`: shorten middle names
///   - `2`: shorten middle and first names
/// - label (label, none): The label to use for email attribution, see `email`.
/// - email (str, content, none): The email to attribute the user to.
/// - ..first (str): The first and middle names.
/// - last (str, array): The last names.
/// -> content
#let author(
  short: 1,
  label: none,
  email: none,
  ..first,
  last,
  _validate: true,
) = {
  if _validate {
    import _valid as z
    _ = z.parse(first, z.sink(positional: z.array(z.string())), scope: ("first",))
    _ = z.parse(last, z.array(z.string(), pre-transform: z.coerce.array), scope: ("last",))
    _ = z.parse(short, z.integer(min: 0, max: 2), scope: ("short",))
    _ = z.parse(email, z.content(optional: true), scope: ("email",))
    _ = z.parse(label, z.label(optional: true), scope: ("label",))
  }

  name(..first, last, short: short, _validate: false)

  if label != none {
    context super(marks.final().marks.at(str(label)))
  }

  if email != none {
    [ ]
    link("mailto:" + email, "<" + email + ">")
  }
}

/// Display an email attribution, i.e. a mark that can be linked to from
/// `author`.
///
/// - mark (content, auto): A symbol used for attribution, the linked authors
///   will have this displayed as a super script. Uses `*` numbering if `auto`.
/// - label (label): The label to use in `author` for automatic attribution.
/// - body (str, content): The body to attribute the authors to, this is often
///   a generic email pattern such as `"<name>@university.com"`, but doesn't
///   have to be.
/// -> content
#let email(
  mark: auto,
  label,
  body,
  _validate: true,
) = {
  if _validate {
    import _valid as z
    _ = z.parse(body, z.content(optional: true), scope: ("body",))
    _ = z.parse(mark, z.either(z.content(optional: true), z.auto_()), scope: ("mark",))
    _ = z.parse(label, z.label(optional: true), scope: ("label",))
  }

  if mark == auto {
    marks.update(m => {
      m.current-auto += 1;
      m.marks.insert(str(label), numbering("*", m.current-auto))
      m
    })
  } else {
    marks.update(m => {
      m.marks.insert(str(label), mark)
      m
    })
  }

  context super(marks.final().marks.at(str(label)))
  body
}
