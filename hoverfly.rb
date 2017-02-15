class Hoverfly < Formula
  desc "lightweight & fantastic service virtualization/API simulation tool, aims to be developer/tester friendly"
  homepage "http://hoverfly.io"
  url "https://github.com/SpectoLabs/hoverfly/archive/v0.10.1.tar.gz"
  version "0.10.1"
  sha256 "cdf99c6a926de9c9e298ac5273589a4310b4bb049fa1ffe42318e2b62e14d97e"

  depends_on "go" => :build
  depends_on "glide" => :build

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/SpectoLabs/hoverfly").install contents
    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"
    cd gopath/"src/github.com/SpectoLabs/hoverfly" do
	system "make", "hoverfly-build", "GIT_TAG_NAME=v0.10.1"
	bin.install "target/hoverfly"
	system "make", "hoverctl-build", "GIT_TAG_NAME=v0.10.1"
	bin.install "target/hoverctl"
    end
  end

  test do
    system "#{bin}/target/hoverfly"
  end
end
