defmodule Gitify.CLI do
  @spotify_key_location "/secret/spotify_key.txt"

  def main(args) do
    args |> parse_args() |> run()
  end

  defp parse_args(args) do
    # IO.inspect(args)

    parsed_args =
      OptionParser.parse(args,
        strict: [help: :boolean, gen: :string, test: :boolean],
        aliases: [h: :help, g: :gen, t: :test]
      )

    # IO.inspect(parsed_args)

    case parsed_args do
      {[help: true], _, _} -> :help
      {[test: true], _, _} -> :test
      {[gen: inp], _, _} -> {:gen, inp}
      _ -> :unknown_command
    end
  end

  defp run(:help) do
    IO.puts("Try checking a list of valid commands.")
  end

  defp run(:test) do
    full_key_path = Path.expand("." <> @spotify_key_location) |> Path.absname()

    case File.read(full_key_path) do
      {:ok, key} when byte_size(key) !== 32 ->
        IO.puts("Are you sure your key at #{@spotify_key_location} is valid?")

      {:ok, key} ->
        IO.puts("Key found: #{key}")
        :inets.start()


      {:error, :enoent} ->
        IO.puts(
          "Error: Spotify API key can't be found. Please enter it into #{@spotify_key_location}"
        )

        File.write(full_key_path, "<---REPLACE WITH KEY--->")
        # _ -> IO.puts("Unknown other error.")
    end
  end

  defp run({:gen, inp}) do
    IO.puts("Got the option #{inp}.")
  end

  defp run(:unknown_command) do
    IO.puts("Sorry, that command was not recognized.")
  end
end
