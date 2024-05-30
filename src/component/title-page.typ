#import "/src/_pkg.typ"
#import "/src/_valid.typ"
#import "/src/theme.typ" as _theme

#let _version = version

/// Generate the default title page.
///
/// - title (str, content): The title for of this document.
/// - subtitle (str, content, none): A subtitle shown below the title.
/// - authors (str, content, array): The authors of the document.
/// - urls (str, array, none): One or more URLs relevant to this document.
/// - version (str, version): The version of this document. A string can be
///   passed explicitly to avoid the automatic `v` prefix.
/// - date (datetime): The date at which this document was created.
/// - abstract (str, content, none): An abstract outlining the purpose and
///   contents of this document.
/// - license (str, content, none): The license of this document or a related
///   piece of intellectual property.
/// - theme (theme): The color theme to use for the title page.
/// -> content
#let make-title-page(
  title: [Title],
  subtitle: [Subtitle],
  authors: "John Doe <john@doe.com>",
  urls: "https://github.com/typst-community/mantodea",
  version: version(0, 1, 0),
  date: datetime(year: 1970, month: 1, day: 1),
  abstract: lorem(100),
  license: "MIT",
  theme: _theme.default,
  _validate: true,
) = {
  if _validate {
    import _valid as z

    _ = z.parse(title, z.content(), scope: ("title",))
    _ = z.parse(subtitle, z.content(optional: true), scope: ("subtitle",))
    _ = z.parse(abstract, z.content(optional: true), scope: ("abstract",))
    _ = z.parse(license, z.content(optional: true), scope: ("license",))
    _ = z.parse(theme, _theme.schema(), scope: ("theme",))

    authors = z.parse(
      authors,
      z.array(z.string(), min: 1, pre-transform: z.coerce.array),
      scope: ("authors",),
    )

    urls = z.parse(
      urls,
      z.array(
        z.string(),
        pre-transform: z.coerce.array,
        post-transform: (self, it) => if it == (none,) { none } else { it },
        optional: true,
      ),
      scope: ("urls",),
    )

    _pkg.t4t.assert.any-type(_version, version)
  } else {
    authors = if type(authors) == str { (authors,) } else { authors }
    urls = if type(urls) == str { (urls,) } else { urls }
  }

  pad(y: 10em, x: 5em, {
    set align(center)
    set block(spacing: 2em)

    block({
      set text(2.5em, theme.colors.primary)
      title
    })

    if subtitle != none {
      block(above: 1em, {
        set text(size: 1.2em)
        subtitle
      })
  	}

    let info = (
      if version != none {
        if type(version) == str { version } else [ v#version ]
      },
      if date != none { date.display() },
      // TODO: license link
      if license != none { license } else { "UNLICENSED" },
    ).filter(it => it != none)

    if info.len() != 0 {
      set text(size: 1.2em)
      grid(columns: info.len(), gutter: 4em, ..info)
    }

    // TODO: author formatting
    block(authors.join(linebreak()))

    if urls != none {
      block(urls.map(link).join(linebreak()))
    }

    if abstract != none {
      set align(left)
      set par(justify: true)
      // show par: set block(spacing: 1.3em)
      abstract
    }
  })

  pagebreak(weak: true)
}
