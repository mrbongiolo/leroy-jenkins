defmodule LeroyJenkins.AlternativeControllerTest do
  use LeroyJenkins.ConnCase

  alias LeroyJenkins.Alternative
  @valid_attrs %{body: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, alternative_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing alternatives"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, alternative_path(conn, :new)
    assert html_response(conn, 200) =~ "New alternative"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, alternative_path(conn, :create), alternative: @valid_attrs
    assert redirected_to(conn) == alternative_path(conn, :index)
    assert Repo.get_by(Alternative, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, alternative_path(conn, :create), alternative: @invalid_attrs
    assert html_response(conn, 200) =~ "New alternative"
  end

  test "shows chosen resource", %{conn: conn} do
    alternative = Repo.insert! %Alternative{}
    conn = get conn, alternative_path(conn, :show, alternative)
    assert html_response(conn, 200) =~ "Show alternative"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, alternative_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    alternative = Repo.insert! %Alternative{}
    conn = get conn, alternative_path(conn, :edit, alternative)
    assert html_response(conn, 200) =~ "Edit alternative"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    alternative = Repo.insert! %Alternative{}
    conn = put conn, alternative_path(conn, :update, alternative), alternative: @valid_attrs
    assert redirected_to(conn) == alternative_path(conn, :show, alternative)
    assert Repo.get_by(Alternative, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    alternative = Repo.insert! %Alternative{}
    conn = put conn, alternative_path(conn, :update, alternative), alternative: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit alternative"
  end

  test "deletes chosen resource", %{conn: conn} do
    alternative = Repo.insert! %Alternative{}
    conn = delete conn, alternative_path(conn, :delete, alternative)
    assert redirected_to(conn) == alternative_path(conn, :index)
    refute Repo.get(Alternative, alternative.id)
  end
end
