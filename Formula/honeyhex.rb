# typed: false
# frozen_string_literal: true

class Honeyhex < Formula
  include Language::Python::Virtualenv

  desc "Distributed ledger of intelligence for agent workflows"
  homepage "https://github.com/rithvik-duddupudi/HoneyHex"
  url "https://files.pythonhosted.org/packages/21/7f/813eb8673df97701748e959de4805677150e490207c581856293ce39a5c7/honeyhex-0.1.0.tar.gz"
  sha256 "b164cd1917101f43b38f248d2486181b9b375957120097f4312b745ffdb111df"

  depends_on "python@3.12"
  depends_on "git"

  def install
    # 1) Use opt_bin so `python3.12` resolves during superenv (keg-only python).
    # 2) Install from the staged sdist (`buildpath`), not `pip install honeyhex==…`:
    #    the latter hits PyPI’s simple API from the sandbox and often fails with
    #    “No matching distribution found (from versions: none)” even when the
    #    package exists — the tarball is already fetched and extracted by Homebrew.
    python = Formula["python@3.12"].opt_bin/"python3.12"
    venv = virtualenv_create(libexec, python)
    venv.pip_install_and_link(buildpath)
  end

  test do
    assert_match(/hex|HoneyHex|Usage/i, shell_output("#{bin}/hex --help"))
  end
end
