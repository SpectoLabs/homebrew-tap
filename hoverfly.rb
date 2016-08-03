class Hoverfly < Formula
  desc "lightweight & fantastic service virtualization/API simulation tool, aims to be developer/tester friendly"
  homepage "http://hoverfly.io"
  url "https://github.com/SpectoLabs/hoverfly/archive/v0.8.0.tar.gz"
  version "0.8.0"
  sha256 "e9ae4e62b6fc7e5fc11f38c9edd3965b35b016a0208bf7280e2473d8148c4ecf"

  depends_on "go" => :build
  depends_on "glide" => :build

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/SpectoLabs/hoverfly").install contents
    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"
    cd gopath/"src/github.com/SpectoLabs/hoverfly" do
	system "make", "hoverfly-build", "GIT_TAG_NAME=v0.8.0"
	bin.install "target/hoverfly"
	system "make", "hoverctl-build", "GIT_TAG_NAME=v0.8.0"
	bin.install "target/hoverctl"
    end
  end

  test do
    system "#{bin}/target/hoverfly"
  end
end
