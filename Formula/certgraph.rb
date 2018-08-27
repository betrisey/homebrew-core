class Certgraph < Formula
  desc "Intelligence tool to crawl the graph of certificate Alternate Names"
  homepage "https://lanrat.github.io/certgraph"
  url "https://github.com/lanrat/certgraph.git",
      :tag => "20180217",
      :revision => "41927387b1544a0d668c57b9883ed18381494ec4"

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/lanrat/certgraph"
    dir.install Dir["*"]

    cd dir do
      system "make", "dep"
      system "make"
      bin.install "certgraph"
      prefix.install_metafiles
    end
  end

  test do
    cmd = "#{bin}/certgraph -depth 0 example.com"
    assert_equal "example.com", shell_output(cmd).strip
  end
end
