defmodule Req.ResponseTest do
  use ExUnit.Case, async: true
  doctest Req.Response, except: [get_header: 2, put_header: 3, delete_header: 2]

  describe "delete_headers/2" do
    test "deletes non-repeating header" do
      response = Req.Response.new(status: 200, headers: [{"content-type", "text/plain"}])

      assert Req.Response.delete_header(response, "content-type").headers == []
    end

    test "deletes repeating headers" do
      response =
        Req.Response.new(
          status: 200,
          headers: [
            {"cache-control", "max-age=30"},
            {"content-type", "text/plain"},
            {"cache-control", "s-maxage=30"}
          ]
        )

      assert Req.Response.delete_header(response, "cache-control").headers == [
               {"content-type", "text/plain"}
             ]
    end
  end
end
