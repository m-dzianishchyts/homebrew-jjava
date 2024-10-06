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
    kernel_dir = share/"jupyter/kernels/java"
    kernel_dir.install Dir["*"]
    unless ENV["JUPYTER_CONFIG_PATH"].to_s.split(File::PATH_SEPARATOR).include?(kernel_dir.to_s)
      ENV["JUPYTER_CONFIG_PATH"] = [ENV["JUPYTER_CONFIG_PATH"], kernel_dir].compact.join(File::PATH_SEPARATOR)
    end
  end
end
