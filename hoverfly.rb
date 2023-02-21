class Hoverfly < Formula
  desc "lightweight & fantastic service virtualization/API simulation tool, aims to be developer/tester friendly"
  homepage "http://hoverfly.io"
  url "https://github.com/SpectoLabs/hoverfly/archive/v2.0.0.tar.gz"
  sha256 "04d24e21b04fbea88a0ed06442139ebeb3c4ec1303366ad960c19f6747294cba"

  depends_on "go" => :build

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/SpectoLabs/hoverfly").install contents
    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"
    cd gopath/"src/github.com/SpectoLabs/hoverfly" do
	system "make", "build", "GIT_TAG_NAME=v#{version}"
	bin.install "target/hoverfly"
	bin.install "target/hoverctl"
    end
  end

  test do
    system "#{bin}/target/hoverfly"
  end
end
