defmodule LeroyJenkins.AlternativeTest do
  use LeroyJenkins.ModelCase

  alias LeroyJenkins.Alternative

  @valid_attrs %{body: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Alternative.changeset(%Alternative{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Alternative.changeset(%Alternative{}, @invalid_attrs)
    refute changeset.valid?
  end
end
