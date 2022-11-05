defmodule AppName.Contexts.Users.UserManagerTest do
  use AppName.DataCase

  alias AppName.Contexts.Users.UserManager

  describe "list/0" do
    test "when doesn't exists users" do
      assert UserManager.list() == %Paginator.Page{
               metadata: %Paginator.Page.Metadata{
                 after: nil,
                 before: nil,
                 limit: 10,
                 total_count: nil,
                 total_count_cap_exceeded: nil
               },
               entries: []
             }
    end

    test "returns all users" do
      insert(:user)

      assert %Paginator.Page{
               metadata: %Paginator.Page.Metadata{
                 after: nil,
                 before: nil,
                 limit: 10,
                 total_count: nil,
                 total_count_cap_exceeded: nil
               },
               entries: [_user]
             } = UserManager.list()
    end

    test "when especifies filter" do
      insert(:user)
      admin = build(:user) |> make_admin() |> insert()

      assert %Paginator.Page{
               metadata: %Paginator.Page.Metadata{
                 after: nil,
                 before: nil,
                 limit: 10,
                 total_count: nil,
                 total_count_cap_exceeded: nil
               },
               entries: [user_admin]
             } = UserManager.list(filters: [is_admin: true])

      assert admin.id == user_admin.id
    end

    test "when passes after cursor" do
      first_user = insert(:user)
      second_user = insert(:user)

      assert %Paginator.Page{
               metadata: %Paginator.Page.Metadata{
                 after: after_cursor,
                 before: nil,
                 limit: 1,
                 total_count: nil,
                 total_count_cap_exceeded: nil
               },
               entries: [first_listed_user]
             } = UserManager.list(limit: 1)

      assert first_user.id == first_listed_user.id

      assert %Paginator.Page{
               metadata: %Paginator.Page.Metadata{
                 after: nil,
                 before: _before_cursor,
                 limit: 1,
                 total_count: nil,
                 total_count_cap_exceeded: nil
               },
               entries: [second_listed_user]
             } = UserManager.list(after: after_cursor, limit: 1)

      assert second_user.id == second_listed_user.id
    end
  end

  describe "create_admin/1" do
    test "when data is valid" do
      email = unique_user_email()
      password = valid_user_password()

      assert {:ok, user} =
               UserManager.create_admin(%{email: email, password: password, is_admin: true})

      assert user.is_admin
    end
  end
end
