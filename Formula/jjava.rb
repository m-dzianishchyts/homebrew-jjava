# typed: true
# frozen_string_literal: true

# This file was generated by Brewtap. DO NOT EDIT.
class Jjava < Formula
  desc "Jupyter kernel for executing java code"
  homepage "https://github.com/m-dzianishchyts/jjava"
  url "https://github.com/m-dzianishchyts/jjava/releases/download/1.0a12/jjava-1.0a12-kernelspec.zip"
  version "1.0a12"
  sha256 "29330835ed9a5709550eca8cfc7b6d85f7df335bf82699354efd4561f7d68dde"
  license "MIT"

  depends_on "java"
  depends_on "jupyterlab"

  def install
    libexec.install Dir["*"]
    system "jupyter kernelspec install #{libexec} --sys-prefix --name=java "
  end

  def test
    jjava_version = Formula["jjava"].version
    jupyter = Formula["jupyterlab"].opt_bin/"jupyter"
    ENV["JUPYTER_PATH"] = share/"jupyter"
    
    assert_match " java ", shell_output("#{jupyter} kernelspec list")

    (testpath/"console.exp").write <<~EOS
      spawn #{jupyter} console --kernel=java
      expect -timeout 30 "In "
      send "System.out.println("Hello world!");\r"
      expect -timeout 10 "In "
      send "\u0004"
      expect -timeout 10 "exit"
      send "y\r"
    EOS
    output = shell_output("expect -f console.exp")
    assert_match "JJava kernel #{r_version}", output
    assert_match "Hello world!", output
  end
end
