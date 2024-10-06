# typed: true
# frozen_string_literal: true

# This file was generated by Brewtap. DO NOT EDIT.
class Jjava < Formula
  desc "Jupyter kernel for executing java code"
  homepage "https://github.com/m-dzianishchyts/jjava"
  url "https://github.com/m-dzianishchyts/jjava/releases/download/1.0a11/jjava-1.0a11-kernelspec.zip"
  version "1.0a11"
  sha256 "6952800b97cbcb7436d29624315ab60f467b8bf804c3916b929ae212d5a9357c"
  license "MIT"

  depends_on "java"
  depends_on "jupyterlab"

  def install
    puts "Current working directory: #{Dir.pwd}"
    files_to_install = Dir["*"]
    puts "Files to install: #{files_to_install.inspect}"

    share_kernel = share/"jupyter/kernels/java"
    share_kernel.install files_to_install

    if share_kernel.children.empty?
      puts "Warning: No files installed in #{share_kernel}. Check your source files."
    else
      puts "Installed files to #{share_kernel}: #{share_kernel.children.map(&:basename).inspect}"
    end

    system "jupyter kernelspec install #{share_kernel} --name=java --user"
  end
end
