# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Docki < Formula
  desc ""
  homepage ""
  url "https://github.com/quirinecker/docki.git", branch: "main"
  version "1.3.0"
  sha256 ""
  license ""
  head "https://github.com/quirinecker/docki.git", branch: "main"

  depends_on "rust" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl@3" => :build
  depends_on "asciidoctor"
  depends_on "asciidoctor-revealjs"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cargo", "install", *std_cargo_args
    system "cargo", "build", "--release", "--bin", "docki"
    bin.install "target/release/docki"

	# Install shell completions
    bash_output = Utils.safe_popen_read("#{bin}/docki", "completions", "bash")
    (bash_completion/"docki").write bash_output

    zsh_output = Utils.safe_popen_read("#{bin}/docki", "completions", "zsh")
    (zsh_completion/"_docki").write zsh_output

    fish_output = Utils.safe_popen_read("#{bin}/docki", "completions", "fish")
    (fish_completion/"docki.fish").write fish_output
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
