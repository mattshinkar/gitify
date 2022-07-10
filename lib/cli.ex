defmodule Gitify.CLI do
  def main(args) do
    args |> parse_args |> run
  end

  defp parse_args(args) do
    parsed_args = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])
    case parsed_args do
      {[help: true], _, _} -> :help
      _ -> :help
    end
  end

  defp run(:help) do
    IO.puts("Hi!")
  end
end
