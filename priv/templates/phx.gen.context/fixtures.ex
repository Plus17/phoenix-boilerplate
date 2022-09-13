  defmacro __using__(_opts) do
    quote do
      def <%= schema.singular %>_factory() do
        %<%= inspect schema.alias %>{
          <%= schema.fixture_params |> Enum.map(fn {key, code} -> "#{key}: #{code}" end) |> Enum.join(",\n") %>
        }
      end
    end
  end
