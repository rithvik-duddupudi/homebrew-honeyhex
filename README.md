# homebrew-honeyhex

Third-party [Homebrew](https://brew.sh/) tap for [**HoneyHex**](https://github.com/rithvik-duddupudi/HoneyHex) — install the `hex` CLI without managing Python paths.

## Install

```bash
brew tap rithvik-duddupudi/honeyhex
brew install honeyhex
hex --help
```

Requires Homebrew’s **python@3.12** and **git** (pulled in as dependencies).

## Maintainer notes

- Formula: [`Formula/honeyhex.rb`](Formula/honeyhex.rb).
- After each **PyPI** release of `honeyhex`, update the **`url`** and **`sha256`** in that file to match the new sdist on [PyPI](https://pypi.org/project/honeyhex/#files).
- The same formula is mirrored in the main repo at [`packaging/homebrew/honeyhex.rb`](../homebrew/honeyhex.rb); keep them in sync when bumping versions.
