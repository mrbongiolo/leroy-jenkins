defmodule LeroyJenkins.AnswerTest do
  use LeroyJenkins.ModelCase

  alias LeroyJenkins.Answer

  @valid_attrs %{address: "some content", cpf: "some content", ip: "some content", name: "some content", suggestions: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Answer.changeset(%Answer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Answer.changeset(%Answer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
