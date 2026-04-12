# typed: false
# frozen_string_literal: true

class Honeyhex < Formula
  include Language::Python::Virtualenv

  # pydantic_core ships a Mach-O bundle with @rpath-based IDs. Homebrew’s default
  # relocation rewrites those to long absolute paths under opt/honeyhex — often exceeding
  # Mach-O header space (“Updated load commands do not fit”). preserve_rpath skips that.
  preserve_rpath

  desc "Distributed ledger of intelligence for agent workflows"
  homepage "https://github.com/rithvik-duddupudi/HoneyHex"
  url "https://files.pythonhosted.org/packages/21/7f/813eb8673df97701748e959de4805677150e490207c581856293ce39a5c7/honeyhex-0.1.0.tar.gz"
  sha256 "b164cd1917101f43b38f248d2486181b9b375957120097f4312b745ffdb111df"

  depends_on "python@3.12"
  depends_on "git"

  def install
    # Staged sdist (`buildpath`) — do not use `pip install honeyhex==…` (PyPI index issues in brew).
    # Homebrew’s `venv.pip_install*` passes `std_pip_args`, which includes `--no-deps`, so the
    # package would install **without** typer/pydantic/GitPython/fs. Call `pip install` on the
    # venv’s Python directly so declared dependencies are pulled in.
    python = Formula["python@3.12"].opt_bin/"python3.12"
    virtualenv_create(libexec, python)
    system libexec/"bin/python", "-m", "pip", "install", "-v", buildpath

    bin.install_symlink libexec/"bin/hex"
    bin.install_symlink libexec/"bin/honeyhex-api"
  end

  test do
    assert_match(/hex|HoneyHex|Usage/i, shell_output("#{bin}/hex --help"))
  end
end
