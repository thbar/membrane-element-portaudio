defmodule Membrane.Element.PortAudio.Mixfile do
  use Mix.Project
  Application.put_env(:bundlex, :membrane_element_portaudio, __ENV__)

  @github_url "https://github.com/membraneframework/membrane-element-portaudio"

  def project do
    [
      app: :membrane_element_portaudio,
      compilers: [:bundlex] ++ Mix.compilers(),
      version: "0.1.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "Membrane Multimedia Framework (PortAudio Element)",
      package: package(),
      name: "Membrane Element: PortAudio",
      source_url: @github_url,
      docs: docs(),
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [], mod: {Membrane.Element.PortAudio, []}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:membrane_core, "~> 0.1.0"},
      {:membrane_common_c, "~> 0.1.0"},
      {:membrane_caps_audio_raw, "~> 0.1.0"},
      {:bundlex, "~> 0.1.0"},
      {:mockery, "~> 2.1", runtime: false},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      maintainers: ["Membrane Team"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => @github_url,
        "Membrane Framework Homepage" => "https://membraneframework.org"
      },
      files: ["lib", "c_src", "mix.exs", "README*", "LICENSE*", ".formatter.exs", "bundlex.exs"]
    ]
  end
end
