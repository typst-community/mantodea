#import "/src/link.typ"

#show heading.where(level: 1): it => pagebreak(weak: true) + it
#set page(width: auto, height: auto, header: counter(footnote).update(0))

= GitHub
#link.forge("https://github.com", "author/repository")

#link.github("author/repository")

= GitLab
#link.forge("https://gitlab.com", "author/repository")

#link.gitlab("author/repository")

= Codeberg
#link.forge("https://codeberg.org", "author/repository")

#link.codeberg("author/repository")

= Generc Git Subdomain
#link.forge("https://git.university.com")

#link.forge("https://git.university.com", label: "git@university")

#link.forge("https://git.university.com", "author/repository")

#link.forge("https://notgit.university.com")

= Packages
#link.package("Hydra")

#link.package-repo("Hydra", version(0, 1, 0))

= Types from Values
#link.type(with-footnote: true, str)
#link.type(with-footnote: true, red)
#link.type(with-footnote: true, left + horizon)

= Types
#let l = link.type.with(with-footnote: true)
#block(width: 200pt,
  for t in link.typst.types.keys() [
    #l(t)
  ]
)
