# typed: true
# frozen_string_literal: true

# This file was generated by Brewtap. DO NOT EDIT.
class Jjava < Formula
  desc "Jupyter kernel for executing java code"
  homepage "https://github.com/m-dzianishchyts/jjava"
  url "https://github.com/m-dzianishchyts/jjava/releases/download/1.0a13/jjava-1.0a13-kernelspec.zip"
  version "1.0a13"
  sha256 "82b54ce8048332c7952cdd0dd466be9c1ed059ba6e576f9d11e0e0f73e092f51"
  license "MIT"

  depends_on "java"
  depends_on "jupyterlab"

  def install
    libexec.install Dir["*"]
    system "jupyter kernelspec install #{libexec} --sys-prefix --name=java "
  end

  test do
    jjava_version = Formula["jjava"].version
    jupyter = Formula["jupyterlab"].opt_bin/"jupyter"
    ENV["JUPYTER_PATH"] = share/"jupyter"
    
    assert_match " java ", shell_output("#{jupyter} kernelspec list")
    
    (testpath/"console.exp").write <<~EOS
    spawn #{jupyter} console --kernel=java
    expect -timeout 30 "In "
    send "System.out.println(\\\"Hello world!\\\");\r"
    expect -timeout 10 "In "
    send "\u0004"
    expect -timeout 10 "exit"
    send "y\r"
    EOS
    output = shell_output("expect -f console.exp")
    assert_match "JJava kernel #{jjava_version}", output
    assert_match "Hello world!", output
  end
end
