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
    # Install from PyPI (wheels for deps) instead of `pip install .` on the extracted
    # sdist — avoids PEP 517 / build-isolation failures on some macOS + Homebrew setups.
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install_and_link("honeyhex==#{version}")
  end

  test do
    assert_match(/hex|HoneyHex|Usage/i, shell_output("#{bin}/hex --help"))
  end
end
