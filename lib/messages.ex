defmodule Messages do

  def message do

    run_query = fn(query_def) ->
      "#{query_def} result"
    end

    async_query = fn(query_def) ->
      caller = self

      spawn(fn ->
        send(caller, {:query_result, run_query.(query_def)})
      end)
    end

    Enum.each(1..5, &async_query.("query #{&1}"))

    get_result = fn ->
      receive do
        {:query_result, result} -> result
      end
    end

    results = Enum.map(1..5, fn(_) -> get_result.() end)
    |> Enum.sort

  end

end
