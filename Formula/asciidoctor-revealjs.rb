# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class AsciidoctorRevealjs < Formula
  desc ""
  homepage ""
  url "https://rubygems.org/downloads/asciidoctor-revealjs-5.1.0.gem", branch: "main"
  version "5.1.0"
  sha256 ""
  license ""

  depends_on "ruby"
  depends_on "asciidoctor"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

	ENV["GEM_HOME"] = libexec
    ENV["GEM_PATH"] = libexec
    system "gem", "install", cached_download, "--no-document", "--install-dir", libexec

    # wrapper that makes `require 'asciidoctor-revealjs'` work with brew’s asciidoctor
    (bin/"asciidoctor-revealjs").write <<~SH
      #!/usr/bin/env bash
      export GEM_HOME="#{libexec}"
      export GEM_PATH="#{libexec}:#{Formula["asciidoctor"].opt_libexec}"
      exec "#{Formula["asciidoctor"].opt_bin}/asciidoctor" -r asciidoctor-revealjs -b revealjs "$@"
    SH
    chmod 0555, bin/"asciidoctor-revealjs"

  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test docki`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
