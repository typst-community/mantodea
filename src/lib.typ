#import "_pkg.typ"
#import "_valid.typ"

#import "author.typ"
#import "component.typ"
#import "example.typ"
#import "link.typ"
#import "theme.typ"
#import "style.typ"
#import "util.typ"

#let _version = version

/// The main template function, this returns a function which is used in a
/// `show`-all rule.
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
/// - theme (theme): The theme to use for this document.
/// -> function
#let mantodea(
  title: [Title],
  subtitle: none,
  authors: "John Doe <john@doe.com>",
  urls: none,
  date: datetime(year: 1970, month: 1, day: 1),
  version: version(0, 1, 0),
  abstract: lorem(100),
  license: "MIT",
  theme: theme.default,
  _validate: true,
) = body => {
  if _validate {
    import _valid as z

    z.parse(title, z.content(), scope: ("title",))
    z.parse(subtitle, z.content(optional: true), scope: ("subtitle",))
    z.parse(abstract, z.content(optional: true), scope: ("abstract",))
    z.parse(license, z.content(optional: true), scope: ("license",))
    z.parse(theme, _theme.schema, scope: ("theme",))

    authors = z.parse(
      z.array(z.string(), min: 1, pre-transform: z.coerce.array),
      authors,
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

  set document(title: title, author: authors)
  show: style.default(theme: theme, _validate: false)

  component.make-title-page(
    title: title,
    subtitle: subtitle,
    authors: authors,
    urls: urls,
    version: version,
    date: date,
    abstract: abstract,
    license: license,
    theme: theme,
    _validate: false,
  )

  component.make-table-of-contents(
    title: heading(outlined: false, numbering: none, level: 2)[Table of Contents],
    columns: 1,
    theme: theme,
    _validate: false,
  )

  body
}
