class Hoverfly < Formula
  desc "lightweight & fantastic service virtualization/API simulation tool, aims to be developer/tester friendly"
  homepage "http://hoverfly.io"
  url "https://github.com/SpectoLabs/hoverfly/archive/v0.8.1.tar.gz"
  version "0.8.1"
  sha256 "1e36065e8f16937a4962af50fe918c819586e54aa7e12b58ec0fa8a8b3fecca5"

  depends_on "go" => :build
  depends_on "glide" => :build

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/SpectoLabs/hoverfly").install contents
    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"
    cd gopath/"src/github.com/SpectoLabs/hoverfly" do
	system "make", "hoverfly-build", "GIT_TAG_NAME=v0.8.1"
	bin.install "target/hoverfly"
	system "make", "hoverctl-build", "GIT_TAG_NAME=v0.8.1"
	bin.install "target/hoverctl"
    end
  end

  test do
    system "#{bin}/target/hoverfly"
  end
end
