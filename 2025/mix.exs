defmodule Aoc2025.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc2025,
      version: "0.1.0",
      deps: [{:aoc, "~> 0.13"}]
    ]
  end

  def cli do
    [preferred_envs: ["aoc.test": :test]]
  end
end
