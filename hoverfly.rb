class Hoverfly < Formula
  desc "lightweight & fantastic service virtualization/API simulation tool, aims to be developer/tester friendly"
  homepage "http://hoverfly.io"
  url "https://github.com/SpectoLabs/hoverfly/archive/v0.11.0.tar.gz"
  version "0.11.0"
  sha256 "a7069aed6c50a7e06373a80ee79f46922362519938bbc797821428d106ebbc3d"

  depends_on "go" => :build

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/SpectoLabs/hoverfly").install contents
    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"
    cd gopath/"src/github.com/SpectoLabs/hoverfly" do
	system "make", "hoverfly-build", "GIT_TAG_NAME=v0.11.0"
	bin.install "target/hoverfly"
	system "make", "hoverctl-build", "GIT_TAG_NAME=v0.11.0"
	bin.install "target/hoverctl"
    end
  end

  test do
    system "#{bin}/target/hoverfly"
  end
end
