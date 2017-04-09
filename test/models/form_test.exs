defmodule LeroyJenkins.FormTest do
  use LeroyJenkins.ModelCase

  alias LeroyJenkins.Form

  @valid_attrs %{description: "some content", question: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Form.changeset(%Form{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Form.changeset(%Form{}, @invalid_attrs)
    refute changeset.valid?
  end
end
