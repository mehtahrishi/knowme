class Knowme < Formula
  include Language::Python::Virtualenv

  desc "Fast, offline command-line tool for system information"
  homepage "https://github.com/mehtahrishi/KnowMe"
  url "https://files.pythonhosted.org/packages/source/k/knowme/knowme-1.0.0.tar.gz"
  sha256 "YOUR_SHA256_HASH_HERE"
  license "MIT"

  depends_on "python@3.11"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/source/p/psutil/psutil-5.9.5.tar.gz"
    sha256 "5410638e4df39c54d957fc51ce03048acd8e6d60abc0f5107af51e5fb566eb3c"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/source/d/distro/distro-1.8.0.tar.gz"
    sha256 "02e111d1dc6a50abb8eed6bf31c3e48ed8b0830d1ea2a1b78c61765c2513fdd8"
  end

  resource "py-cpuinfo" do
    url "https://files.pythonhosted.org/packages/source/p/py-cpuinfo/py-cpuinfo-9.0.0.tar.gz"
    sha256 "3cdbbf3fac90dc6f118bfd64384f309edeadd902d7c8fb17f02ffa1fc3f49690"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/source/r/requests/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "gputil" do
    url "https://files.pythonhosted.org/packages/source/G/GPUtil/GPUtil-1.4.0.tar.gz"
    sha256 "099e52c65e512cdfa8c8763fca67f5a5c2afb63469602d5dcb4d296b3661efb9"
  end

  resource "screeninfo" do
    url "https://files.pythonhosted.org/packages/source/s/screeninfo/screeninfo-0.8.1.tar.gz"
    sha256 "9983076bcc7e34402a1a9e4d7dabf3fb3f2a685669b5129c165d3b5ca7c6c9b9"
  end

  resource "ifaddr" do
    url "https://files.pythonhosted.org/packages/source/i/ifaddr/ifaddr-0.2.0.tar.gz"
    sha256 "cc0cbfcaabf765d44595825fb96a99bb12c79716b73b44330ea38ee2b0c4aed4"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/knowme", "--help"
  end
end
