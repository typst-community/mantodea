#import "_pkg.typ"
#import "_valid.typ"

#let schema = _valid.dictionary.with((
  fonts: _valid.dictionary((
    serif: _valid.array(_valid.string()),
    sans:  _valid.array(_valid.string()),
    mono:  _valid.array(_valid.string()),

    text:     _valid.array(_valid.string()),
    headings: _valid.array(_valid.string()),
    code:     _valid.array(_valid.string()),
  )),
  colors: _valid.dictionary((
    primary:   _valid.paint(),
    secondary: _valid.paint(),
    argument:  _valid.paint(),
    option:    _valid.paint(),
    value:     _valid.paint(),
    command:   _valid.paint(),
    comment:   _valid.paint(),
    module:    _valid.paint(),

    text:      _valid.paint(),
    muted:     _valid.paint(),

    info:      _valid.paint(),
    warning:   _valid.paint(),
    error:     _valid.paint(),
    success:   _valid.paint(),

    types: _valid.dictionary((
      // special
      any:        _valid.paint(),
      "auto":     _valid.paint(),
      "none":     _valid.paint(),

      // foundations
      arguments:  _valid.paint(),
      array:      _valid.paint(),
      bool:       _valid.paint(),
      bytes:      _valid.paint(),
      content:    _valid.paint(),
      datetime:   _valid.paint(),
      dictionary: _valid.paint(),
      float:      _valid.paint(),
      function:   _valid.paint(),
      int:        _valid.paint(),
      location:   _valid.paint(),
      plugin:     _valid.paint(),
      regex:      _valid.paint(),
      selector:   _valid.paint(),
      str:        _valid.paint(),
      type:       _valid.paint(),
      label:      _valid.paint(),

      // layout
      alignment:  _valid.paint(),
      angle:      _valid.paint(),
      direction:  _valid.paint(),
      fraction:   _valid.paint(),
      length:     _valid.paint(),
      ratio:      _valid.paint(),
      relative:   _valid.paint(),

      // visualize
      color:      _valid.paint(),
      gradient:   _valid.paint(),
      stroke:     _valid.paint(),
    )),
  )),
))

#let default = (
  fonts: (
    serif: ("Linux Libertine", "Liberation Serif"),
    sans:  ("Liberation Sans", "Helvetica Neue", "Helvetica"),
    mono:  ("Liberation Mono",),

    text:     ("Linux Libertine", "Liberation Serif"),
    headings: ("Liberation Sans", "Helvetica Neue", "Helvetica"),
    code:     ("Liberation Mono",),
  ),
  colors: (
    primary:   eastern,
    secondary: teal,
    argument:  navy,
    option:    rgb(214, 182, 93),
    value:     rgb(181, 2, 86),
    command:   blue,
    comment:   gray,
    module:    rgb(140, 63, 178),

    text:      rgb(35, 31, 32),
    muted:     luma(210),

    info:      rgb(23, 162, 184),
    warning:   rgb(255, 193, 7),
    error:     rgb(220, 53, 69),
    success:   rgb(40, 167, 69),

    types: {
      let red = rgb(255, 203, 195)
      let gray = rgb(239, 240, 243)
      let purple = rgb(230, 218, 255)
      let gradient-colors = (
        (rgb("#7cd5ff"), 0%),
        (rgb("#a6fbca"), 33%),
        (rgb("#fff37c"), 66%),
        (rgb("#ffa49d"), 100%),
      )

      (
        // special
        any: gray,
        "auto": red,
        "none": red,

        // foundations
        arguments: gray,
        array: gray,
        bool: rgb(255, 236, 193),
        bytes: gray,
        content: rgb(166, 235, 229),
        datetime: gray,
        dictionary: gray,
        float: purple,
        function: gray,
        int: purple,
        location: gray,
        plugin: gray,
        regex: gray,
        selector: gray,
        str: rgb(209, 255, 226),
        type: gray,
        label: rgb(167, 234, 255),

        // layout
        alignment: gray,
        angle: purple,
        direction: gray,
        fraction: purple,
        length: purple,
        ratio: purple,
        relative: purple,

        // visualize
        color: gradient.linear(..gradient-colors),
        gradient: gradient.linear(..gradient-colors),
        stroke: gray,
      )
    }
  ),
)
